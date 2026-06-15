-- Fraud Question:
-- Can a simple rule identify high-risk TRANSFER and CASH_OUT transactions?

-- Rule Logic:
-- Flag transactions where:
-- 1. Transaction type is TRANSFER or CASH_OUT
-- 2. Transaction amount is greater than or equal to 200,000

-- Business Use:
-- This query tests a first baseline fraud detection rule and evaluates
-- how many fraud transactions it captures versus how many false positives it creates.

WITH rule_results AS (
    SELECT
        type,
        amount,
        isFraud,
        CASE
            WHEN type IN ('TRANSFER', 'CASH_OUT')
                 AND amount >= 200000
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