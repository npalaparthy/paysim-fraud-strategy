# Weighted Risk Scoring Notes

## Objective

The objective of this step was to create a weighted fraud risk score using the fraud signals developed during feature engineering.

Instead of treating every fraud signal equally, stronger signals were assigned higher weights.

## Fraud Signals and Weights

| Fraud Signal | Weight |
|---|---:|
| risky_type_flag | 2 |
| high_amount_flag | 2 |
| high_depletion_flag | 3 |
| destination_mismatch_flag | 2 |

Maximum possible score: 9

## Risk Tier Logic

| Score Range | Risk Tier |
|---:|---|
| 0–2 | Low |
| 3–5 | Medium |
| 6–7 | High |
| 8–9 | Critical |

## Weighted Risk Tier Results

| Risk Tier | Total Transactions | Fraud Transactions | Fraud Rate |
|---|---:|---:|---:|
| Critical | 21,926 | 1,860 | 0.084831 |
| High | 249,103 | 4,236 | 0.017005 |
| Medium | 2,055,975 | 2,084 | 0.001014 |
| Low | 4,035,616 | 33 | 0.000008 |

## Interpretation

The weighted risk score showed clear separation between low-risk and high-risk transactions.

Low-risk transactions had almost no fraud, while Critical-risk transactions had the highest fraud concentration at 8.48%.

This suggests that weighted fraud scoring can help prioritize investigation workload by focusing attention on transactions with stronger combinations of fraud signals.

## Business Conclusion

Weighted risk scoring provides a more structured way to prioritize transactions than using a single rule or equal signal count.

Critical and High tiers should be reviewed first, while Low-risk transactions may require little or no manual review.

This approach supports scalable fraud review by reducing unnecessary workload and focusing investigative resources on higher-risk activity.