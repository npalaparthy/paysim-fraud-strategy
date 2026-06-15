# Rule Comparison Notes

## Objective

The objective of this analysis was to compare multiple fraud detection rule versions and evaluate the trade-off between fraud capture and alert quality.

The rules compared were:

1. Rule 1: TRANSFER/CASH_OUT transactions with amount >= 200,000
2. Rule 2: TRANSFER/CASH_OUT transactions with amount >= 500,000
3. Rule 3: TRANSFER/CASH_OUT transactions with amount >= 500,000 and 90% origin balance depletion

## Rule Comparison Results

| Rule | Flagged Transactions | True Positives | False Positives | False Negatives | Recall | Precision |
|---|---:|---:|---:|---:|---:|---:|
| Rule 1: Type + Amount >= 200K | 1,197,669 | 5,471 | 1,192,198 | 2,742 | 0.6661 | 0.0046 |
| Rule 2: Type + Amount >= 500K | 314,301 | 3,864 | 310,437 | 4,349 | 0.4705 | 0.0123 |
| Rule 3: Type + Amount >= 500K + 90% Depletion | 158,363 | 3,725 | 154,638 | 4,488 | 0.4535 | 0.0235 |

## Interpretation

Rule 1 captured the highest number of fraud transactions, with a recall of 66.61%. However, it generated a very high alert volume and a large number of false positives. This means the rule was effective at catching fraud but created significant alert noise.

Rule 2 increased the amount threshold from 200,000 to 500,000. This reduced flagged transactions from 1,197,669 to 314,301 and improved precision from 0.46% to 1.23%. However, recall decreased from 66.61% to 47.05%, meaning more fraud transactions were missed.

Rule 3 added a 90% origin balance depletion condition to the 500,000 amount threshold. This reduced false positives from 310,437 to 154,638 compared with Rule 2. Precision improved from 1.23% to 2.35%, while recall only decreased slightly from 47.05% to 45.35%.

## Business Conclusion

Rule 3 provides the best balance between alert quality and fraud capture among the tested rules.

Although Rule 1 catches the most fraud, it creates excessive false positives and would likely overwhelm a fraud review team. Rule 3 reduces alert volume, improves precision, and maintains a similar level of fraud capture compared with the 500,000 amount-only rule.

This shows that combining transaction amount with balance behaviour creates a stronger fraud detection rule than relying on transaction amount alone.

## Key Learning

Fraud rule design requires balancing recall and precision.

- Higher recall means more fraud is caught.
- Higher precision means alerts are cleaner and less noisy.
- A good fraud rule should not only catch fraud, but also reduce unnecessary review workload.