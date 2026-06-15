# Executive Summary – PaySim Fraud Strategy Project

## Business Problem

Financial institutions process millions of transactions daily, making it impractical to manually review every transaction for fraud.

The objective of this project was to identify fraud patterns within the PaySim dataset and develop a risk-based alert prioritization framework that balances fraud detection effectiveness with operational efficiency.

## Dataset Overview

* Total transactions analyzed: 6,362,620
* Fraud transactions: 8,213
* Fraud prevalence: 0.13%

The dataset exhibited a highly imbalanced fraud distribution, similar to real-world payment environments where the vast majority of transactions are legitimate.

## Methodology

The project followed an end-to-end fraud analytics approach:

1. Performed exploratory data analysis to understand transaction behaviour and fraud distribution.
2. Identified high-risk transaction types and tested fraud detection thresholds.
3. Evaluated rule performance using recall, precision, false positives, and false negatives.
4. Engineered fraud features, including:

   * Risky transaction types
   * High transaction amounts
   * High origin account depletion
   * Destination balance mismatches
5. Developed a weighted fraud risk scoring framework.
6. Segmented transactions into Low, Medium, High, and Critical risk tiers.
7. Evaluated alert prioritization strategies based on fraud capture and operational workload.

## Key Findings

* Fraud activity was concentrated almost entirely within TRANSFER and CASH_OUT transactions.
* Fraud rates increased substantially as weighted fraud risk scores increased.
* Critical-risk transactions had the highest fraud concentration.

### Fraud Rates by Risk Tier

| Risk Tier | Fraud Rate |
| --------- | ---------: |
| Critical  |      8.48% |
| High      |      1.70% |
| Medium    |      0.10% |
| Low       |    0.0008% |

## Alert Prioritization Results

| Review Strategy          | Alerts Reviewed | Fraud Caught | Recall | Precision |
| ------------------------ | --------------: | -----------: | -----: | --------: |
| Critical only            |          21,926 |        1,860 | 22.65% |     8.48% |
| High + Critical          |         271,029 |        6,096 | 74.22% |     2.25% |
| Medium + High + Critical |       2,327,004 |        8,180 | 99.60% |     0.35% |

## Recommendation

Reviewing High and Critical risk tiers provides the best balance between fraud detection effectiveness and operational efficiency.

This strategy captures approximately 74% of fraud while limiting review volume to approximately 271,000 transactions.

Although including Medium-risk alerts increases fraud capture to nearly 100%, it increases review workload more than eightfold while substantially reducing precision.

## Business Impact

This project demonstrates how fraud analytics can move beyond rule creation to support operational decision-making through risk scoring and alert prioritization. The framework illustrates the trade-offs fraud teams face between maximizing fraud capture and maintaining sustainable investigation capacity.
