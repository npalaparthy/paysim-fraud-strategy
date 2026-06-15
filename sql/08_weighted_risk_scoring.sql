WITH features AS (
    SELECT
        type,
        amount,
        oldbalanceOrg,
        newbalanceDest,
        oldbalanceDest,
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
    risk_tier,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(SUM(isFraud) * 1.0 / COUNT(*), 6) AS fraud_rate
FROM tiered
GROUP BY risk_tier
ORDER BY fraud_rate DESC;