WITH features AS (
    SELECT
        step,
        type,
        amount,
        oldbalanceOrg,
        newbalanceOrig,
        oldbalanceDest,
        newbalanceDest,
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
        END AS destination_mismatch_flag,

        CASE
            WHEN oldbalanceOrg > 0
            THEN ROUND(amount / oldbalanceOrg, 4)
            ELSE NULL
        END AS origin_depletion_ratio,

        CASE
            WHEN amount >= 1000000 THEN 'Very High'
            WHEN amount >= 500000 THEN 'High'
            WHEN amount >= 200000 THEN 'Medium'
            ELSE 'Low'
        END AS amount_risk_bucket

    FROM paysim
),

scored_features AS (
    SELECT
        *,
        risky_type_flag
        + high_amount_flag
        + high_depletion_flag
        + destination_mismatch_flag AS fraud_signal_count
    FROM features
),

risk_tiers AS (
    SELECT
        *,
        CASE
            WHEN fraud_signal_count >= 4 THEN 'Critical'
            WHEN fraud_signal_count = 3 THEN 'High'
            WHEN fraud_signal_count = 2 THEN 'Medium'
            ELSE 'Low'
        END AS risk_tier
    FROM scored_features
)

SELECT *
FROM risk_tiers;