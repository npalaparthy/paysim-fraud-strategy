# Threshold Tuning Notes

## Objective

Evaluate how different amount thresholds affect fraud capture, alert volume, false positives, recall, and precision.

## Fraud Question

Which amount threshold provides the best balance between fraud capture and alert volume?

## Rule Logic

The rule flags a transaction when:

- Transaction type is `TRANSFER` or `CASH_OUT`
- Transaction amount is greater than or equal to the tested threshold

Tested thresholds:

- 50,000
- 100,000
- 200,000
- 500,000
- 1,000,000

## SQL Approach

A CTE-based threshold table was used to test multiple amount thresholds in one query. Each threshold was applied to the full dataset using a `CROSS JOIN`.

## Metrics Used

- Flagged transactions
- True positives
- False positives
- False negatives
- Recall
- Precision

## Key Findings

As the amount threshold increased, flagged transactions and false positives decreased significantly, while recall also decreased.

Precision improved as the threshold became stricter, but remained low overall. This suggests that transaction amount helps reduce alert volume, but amount alone is not sufficient to create a high-quality fraud detection rule.

The 200,000 threshold captured more fraud but created excessive false positives. The 500,000 threshold significantly reduced alert volume and improved precision, but missed more fraud.

## Business Interpretation

Based on the current rule, the 500,000 threshold may be a more practical baseline for workload control. However, further rule improvements are needed to increase precision without losing excessive recall.

This confirms that threshold tuning is a trade-off between fraud capture, false-positive reduction, review workload, and customer friction.

## Output Created

- `outputs/threshold_tuning_results.csv`
- `sql/03_threshold_tuning.sql`

## Next Analytical Step

Improve the fraud rule by adding additional risk indicators beyond amount and transaction type.