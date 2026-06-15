# Feature Engineering Notes

## Objective

The objective of this step was to convert raw transaction data into reusable fraud risk features.

Feature engineering helps transform raw fields into fraud signals that can support rule tuning, risk tiering, and future risk scoring.

## Features Created

The following features were created:

| Feature | Description |
|---|---|
| risky_type_flag | Flags TRANSFER and CASH_OUT transactions as risky transaction types |
| high_amount_flag | Flags transactions with amount >= 500,000 |
| high_depletion_flag | Flags transactions where the amount is at least 90% of the origin balance |
| destination_mismatch_flag | Flags risky-type transactions where the receiver balance change does not match the transaction amount |
| origin_depletion_ratio | Calculates amount divided by old origin balance |
| amount_risk_bucket | Groups transaction amounts into Low, Medium, High, and Very High buckets |
| fraud_signal_count | Counts how many fraud warning signs are present |
| risk_tier | Converts fraud signal count into Low, Medium, High, or Critical risk tiers |

## Fraud Signal Count Results

| Fraud Signal Count | Total Transactions | Fraud Transactions | Fraud Rate |
|---:|---:|---:|---:|
| 0 | 2,751,765 | 0 | 0.000000 |
| 1 | 2,098,314 | 33 | 0.000016 |
| 2 | 1,241,512 | 2,084 | 0.001679 |
| 3 | 249,103 | 4,236 | 0.017005 |
| 4 | 21,926 | 1,860 | 0.084831 |

## Risk Tier Results

| Risk Tier | Total Transactions | Fraud Transactions | Fraud Rate |
|---|---:|---:|---:|
| Critical | 21,926 | 1,860 | 0.084831 |
| High | 249,103 | 4,236 | 0.017005 |
| Medium | 1,241,512 | 2,084 | 0.001679 |
| Low | 4,850,079 | 33 | 0.000007 |

## Interpretation

The fraud signal count showed clear risk separation. Transactions with more fraud warning signs had higher fraud rates.

Transactions with zero fraud signals had no fraud, while transactions with four fraud signals had the highest fraud rate at 8.48%.

The risk tiering approach also showed strong separation. Low-risk transactions had almost no fraud, while Critical-risk transactions had the highest fraud concentration.

## Business Conclusion

Combining multiple fraud signals is more effective than relying on a single indicator.

The feature engineering process created reusable fraud indicators that can help prioritize investigation workload. Critical and High risk tiers can be reviewed first, while Low-risk transactions may require less manual review.

This approach supports a more scalable fraud review strategy by focusing attention on transactions with stronger risk characteristics.

## Key Learning

Feature engineering converts raw transaction fields into useful fraud warning signs.

A single signal may be noisy, but multiple signals together can create stronger fraud risk separation.