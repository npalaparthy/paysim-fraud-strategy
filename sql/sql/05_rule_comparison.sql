WITH rule_flags AS (
    SELECT
        isFraud,

        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount >= 200000
            THEN 1
            ELSE 0
        END AS rule_200k_flag,

        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount >= 500000
            THEN 1
            ELSE 0
        END AS rule_500k_flag,

        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount >= 500000
                 AND oldbalanceOrg > 0
                 AND amount >= oldbalanceOrg * 0.90
            THEN 1
            ELSE 0
        END AS rule_500k_depletion_flag
    FROM paysim
),

rule_results AS (
    SELECT
        'Rule 1: Type + Amount >= 200K' AS rule_name,
        rule_200k_flag AS rule_flag,
        isFraud
    FROM rule_flags

    UNION ALL

    SELECT
        'Rule 2: Type + Amount >= 500K' AS rule_name,
        rule_500k_flag AS rule_flag,
        isFraud
    FROM rule_flags

    UNION ALL

    SELECT
        'Rule 3: Type + Amount >= 500K + 90% Depletion' AS rule_name,
        rule_500k_depletion_flag AS rule_flag,
        isFraud
    FROM rule_flags
)

SELECT
    rule_name,
    SUM(rule_flag) AS flagged_transactions,
    SUM(CASE WHEN rule_flag = 1 AND isFraud = 1 THEN 1 ELSE 0 END) AS true_positives,
    SUM(CASE WHEN rule_flag = 1 AND isFraud = 0 THEN 1 ELSE 0 END) AS false_positives,
    SUM(CASE WHEN rule_flag = 0 AND isFraud = 1 THEN 1 ELSE 0 END) AS false_negatives,

    ROUND(
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 1 THEN 1 ELSE 0 END) * 1.0
        / SUM(isFraud),
        4
    ) AS recall,

    ROUND(
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 1 THEN 1 ELSE 0 END) * 1.0
        / SUM(rule_flag),
        4
    ) AS precision

FROM rule_results
GROUP BY rule_name
ORDER BY precision DESC;