# Initial Data Review

## Objective

Review the PaySim transaction dataset to understand the available fields, transaction volume, fraud label distribution, and fraud concentration by transaction type.

## Dataset Overview

The dataset contains transaction-level records with transaction type, amount, origin account, destination account, account balances, fraud label, and system-generated fraud flag.

## Data Shape

The dataset contains 6,362,620 transactions and 11 fields.

## Fraud Label Distribution

The dataset is highly imbalanced.

- Non-fraud transactions: 6,354,407
- Fraud transactions: 8,213
- Fraud proportion: approximately 0.1291%

## Transaction Type Review

Transaction volume by type:

- CASH_OUT: 2,237,500
- PAYMENT: 2,151,495
- CASH_IN: 1,399,284
- TRANSFER: 532,909
- DEBIT: 41,432

## Fraud Concentration by Transaction Type

Fraud was observed only in the following transaction types:

- TRANSFER
- CASH_OUT

TRANSFER had the highest fraud rate, while CASH_OUT had the highest number of fraud transactions.

## Key Initial Insight

Transaction volume and fraud risk are not the same. CASH_OUT has the highest number of fraud cases, but TRANSFER has the higher fraud rate. This supports focusing the first detection rule on TRANSFER and CASH_OUT transactions.

## Output Created

The transaction type fraud summary was exported to:

`outputs/transaction_type_fraud_summary.csv`

## Next Analytical Step

Use SQL to evaluate fraud concentration by transaction type and begin developing the first fraud detection rule.