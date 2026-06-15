WITH features AS (
    SELECT
        isFraud,

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
),

scored AS (
    SELECT
        *,
        risky_type_flag * 2
        + high_amount_flag * 2
        + high_depletion_flag * 3
        + destination_mismatch_flag * 2 AS fraud_risk_score
    FROM features
),

tiered AS (
    SELECT
        *,
        CASE
            WHEN fraud_risk_score BETWEEN 0 AND 2 THEN 'Low'
            WHEN fraud_risk_score BETWEEN 3 AND 5 THEN 'Medium'
            WHEN fraud_risk_score BETWEEN 6 AND 7 THEN 'High'
            WHEN fraud_risk_score >= 8 THEN 'Critical'
        END AS risk_tier
    FROM scored
)

SELECT
    'Critical only' AS review_strategy,
    COUNT(*) AS alerts_reviewed,
    SUM(isFraud) AS fraud_caught,
    ROUND(SUM(isFraud) * 1.0 / 8213, 4) AS recall,
    ROUND(SUM(isFraud) * 1.0 / COUNT(*), 4) AS precision
FROM tiered
WHERE risk_tier = 'Critical'

UNION ALL

SELECT
    'High + Critical' AS review_strategy,
    COUNT(*) AS alerts_reviewed,
    SUM(isFraud) AS fraud_caught,
    ROUND(SUM(isFraud) * 1.0 / 8213, 4) AS recall,
    ROUND(SUM(isFraud) * 1.0 / COUNT(*), 4) AS precision
FROM tiered
WHERE risk_tier IN ('High', 'Critical')

UNION ALL

SELECT
    'Medium + High + Critical' AS review_strategy,
    COUNT(*) AS alerts_reviewed,
    SUM(isFraud) AS fraud_caught,
    ROUND(SUM(isFraud) * 1.0 / 8213, 4) AS recall,
    ROUND(SUM(isFraud) * 1.0 / COUNT(*), 4) AS precision
FROM tiered
WHERE risk_tier IN ('Medium', 'High', 'Critical');