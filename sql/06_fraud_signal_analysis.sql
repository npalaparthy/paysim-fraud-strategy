WITH signal_flags AS (
    SELECT
        isFraud,
        type,

        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
            THEN 1 ELSE 0
        END AS risky_type_flag,

        CASE
            WHEN amount >= 500000
            THEN 1 ELSE 0
        END AS high_amount_flag,

        CASE
            WHEN oldbalanceOrg > 0
                 AND amount >= oldbalanceOrg * 0.90
            THEN 1 ELSE 0
        END AS high_depletion_flag,

        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount > 0
                 AND ABS((newbalanceDest - oldbalanceDest) - amount) > 1
            THEN 1 ELSE 0
        END AS destination_mismatch_flag

    FROM paysim
)

SELECT
    isFraud,
    COUNT(*) AS total_transactions,

    ROUND(AVG(risky_type_flag), 4) AS risky_type_rate,
    ROUND(AVG(high_amount_flag), 4) AS high_amount_rate,
    ROUND(AVG(high_depletion_flag), 4) AS high_depletion_rate,

    ROUND(
        SUM(destination_mismatch_flag) * 1.0
        / NULLIF(SUM(risky_type_flag), 0),
        4
    ) AS destination_mismatch_rate_within_risky_types

FROM signal_flags
GROUP BY isFraud
ORDER BY isFraud DESC;