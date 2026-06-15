-- Fraud Question:
-- Which transaction types have the highest fraud concentration?

-- Business Use:
-- This query identifies transaction types with the highest fraud rate and supports
-- prioritizing fraud detection logic toward higher-risk transaction categories.

SELECT
    type,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(SUM(isFraud) * 1.0 / COUNT(*), 6) AS fraud_rate
FROM paysim
GROUP BY type
ORDER BY fraud_rate DESC;