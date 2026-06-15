# Fraud Signal Analysis Notes

## Objective

The objective of this analysis was to identify fraud signals that can be used later for feature engineering, rule improvement, and risk scoring.

A fraud signal is a warning sign created from raw transaction data.

## Signals Tested

The following signals were tested:

1. Risky transaction type  
2. High transaction amount  
3. Origin balance depletion  
4. Destination balance mismatch  

## Signal Summary Results

| isFraud | Total Transactions | Risky Type Rate | High Amount Rate | High Depletion Rate | Destination Mismatch Rate Within Risky Types |
|---:|---:|---:|---:|---:|---:|
| 1 | 8,213 | 1.0000 | 0.4705 | 0.9784 | 0.5158 |
| 0 | 6,354,407 | 0.4347 | 0.0529 | 0.3191 | 0.0961 |

## Interpretation

All fraud transactions occurred in TRANSFER and CASH_OUT transaction types. This confirms that transaction type is an important fraud signal in this dataset.

High amount transactions were more common among fraud transactions. Approximately 47.05% of fraud transactions were at least 500,000, compared with only 5.29% of non-fraud transactions.

Origin balance depletion was one of the strongest signals. Approximately 97.84% of fraud transactions depleted at least 90% of the origin account balance, compared with 31.91% of non-fraud transactions.

Destination balance mismatch was tested within risky transaction types only. Approximately 51.58% of fraud transactions had a destination balance mismatch, compared with 9.61% of non-fraud transactions. This suggests that receiver-side balance behaviour can provide an additional fraud signal.

## Business Conclusion

Fraud in this dataset is not random. It is concentrated in specific transaction types and is associated with high transaction amounts, origin balance depletion, and abnormal destination balance movement.

These signals can be combined to build stronger fraud detection rules and a fraud risk scoring framework.

## Key Learning

A single fraud signal may not be enough on its own. Combining multiple signals can create stronger fraud detection logic.

- Transaction type shows where fraud is concentrated.
- Amount shows transaction size risk.
- Origin balance depletion shows sender-side behaviour.
- Destination mismatch shows receiver-side abnormal movement.