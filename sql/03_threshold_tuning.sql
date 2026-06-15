-- Fraud Question:
-- Which amount threshold provides the best balance between fraud capture and alert volume?

-- Business Use:
-- This query evaluates a fraud detection rule across multiple amount thresholds.
-- It compares alert volume, true positives, false positives, false negatives,
-- recall, and precision for each threshold.

WITH thresholds AS (
    SELECT 50000 AS threshold
    UNION ALL 
    SELECT 100000
    UNION ALL 
    SELECT 200000
    UNION ALL 
    SELECT 500000
    UNION ALL 
    SELECT 1000000
),

rule_flags AS (
    SELECT
        th.threshold AS rule_threshold,
        t.type,
        t.amount,
        t.isFraud,
        CASE
            WHEN t.type IN ('TRANSFER', 'CASH_OUT')
                 AND t.amount >= th.threshold
            THEN 1
            ELSE 0
        END AS rule_flag
    FROM paysim t
    CROSS JOIN thresholds th
),

rule_summary AS (
    SELECT
        rule_threshold,
        COUNT(*) AS total_rule_tests,
        SUM(rule_flag) AS flagged_transactions,
        SUM(isFraud) AS total_fraud_transactions,
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 1 THEN 1 ELSE 0 END) AS true_positives,
        SUM(CASE WHEN rule_flag = 1 AND isFraud = 0 THEN 1 ELSE 0 END) AS false_positives,
        SUM(CASE WHEN rule_flag = 0 AND isFraud = 1 THEN 1 ELSE 0 END) AS false_negatives
    FROM rule_flags
    GROUP BY rule_threshold
)

SELECT
    rule_threshold,
    flagged_transactions,
    total_fraud_transactions,
    true_positives,
    false_positives,
    false_negatives,
    ROUND(true_positives * 1.0 / total_fraud_transactions, 4) AS recall,
    ROUND(true_positives * 1.0 / flagged_transactions, 4) AS precision
FROM rule_summary
ORDER BY rule_threshold;