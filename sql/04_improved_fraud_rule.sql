-- Fraud Question:
-- Can adding balance depletion improve the fraud detection rule?

-- Rule Logic:
-- Flag transactions where:
-- 1. Transaction type is TRANSFER or CASH_OUT
-- 2. Amount is greater than or equal to 500,000
-- 3. Transaction amount is at least 90% of the origin account balance

-- Business Use:
-- This query tests whether adding origin balance depletion reduces false positives
-- while maintaining reasonable fraud capture.

WITH rule_results AS (
    SELECT
        type,
        amount,
        oldbalanceOrg,
        isFraud,
        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount >= 500000
                 AND oldbalanceOrg > 0
                 AND amount >= oldbalanceOrg * 0.90
            THEN 1
            ELSE 0
        END AS rule_flag
    FROM paysim
),

rule_summary AS (
    SELECT
        COUNT(*) AS total_transactions,
        SUM(rule_flag) AS flagged_transactions,
        SUM(isFraud) AS total_fraud_transactions,
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 1 THEN 1 ELSE 0 END) AS true_positives,
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 0 THEN 1 ELSE 0 END) AS false_positives,
        SUM(CASE WHEN rule_flag = 0 AND isFraud = 1 THEN 1 ELSE 0 END) AS false_negatives
    FROM rule_results
)

SELECT
    total_transactions,
    flagged_transactions,
    total_fraud_transactions,
    true_positives,
    false_positives,
    false_negatives,
    ROUND(true_positives * 1.0 / total_fraud_transactions, 4) AS recall,
    ROUND(true_positives * 1.0 / flagged_transactions, 4) AS precision
FROM rule_summary;