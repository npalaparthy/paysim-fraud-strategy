# Improved Fraud Rule Notes

## Objective

Improve the baseline fraud detection rule by adding balance behaviour as an additional risk signal.

## Fraud Question

Can adding origin balance depletion improve fraud rule performance?

## Rule Logic

The improved rule flags a transaction when:

- Transaction type is `TRANSFER` or `CASH_OUT`
- Transaction amount is greater than or equal to `500,000`
- Transaction amount is at least 90% of the origin account balance

Balance depletion condition:

```sql
amount >= oldbalanceOrg * 0.90

SQL Approach

The rule uses CASE WHEN to create a rule flag. The improved rule combines transaction type, amount threshold, and origin balance depletion.

Metrics Used
Flagged transactions
True positives
False positives
False negatives
Recall
Precision
Key Findings

The improved rule reduced alert volume and false positives compared to the 500,000 amount-threshold rule.

Previous 500,000 threshold-only rule:

Flagged transactions: 314,301
True positives: 3,864
False positives: 310,437
Recall: 47.05%
Precision: 1.23%

Improved rule with balance depletion:

Flagged transactions: 158,363
True positives: 3,725
False positives: 154,638
Recall: 45.35%
Precision: 2.35%
Business Interpretation

Adding the high-depletion balance behaviour condition significantly reduced alert volume and false positives while only slightly reducing recall. Precision improved from 1.23% to 2.35%, indicating that balance depletion is a useful additional risk signal when combined with transaction type and amount threshold.

Conclusion

The improved rule is cleaner than the baseline amount-threshold rule. It reduces operational review workload and improves alert quality, although additional fraud signals are still needed to further improve precision.

Output Created
outputs/improved_fraud_rule_results.csv
sql/04_improved_fraud_rule.sql
Next Analytical Step

Compare rule versions side by side and continue testing additional fraud indicators.