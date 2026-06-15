# Dataset Notes

## Dataset

PaySim Synthetic Financial Dataset for Fraud Detection

## Dataset Purpose

The dataset is used to support fraud rule development, threshold testing, feature engineering, and fraud-risk model preparation.

## Transaction-Level Structure

Each row represents one financial transaction.

## Key Fields

- `step` — time step of the transaction
- `type` — transaction type
- `amount` — transaction amount
- `nameOrig` — originating account
- `oldbalanceOrg` — originating account balance before transaction
- `newbalanceOrig` — originating account balance after transaction
- `nameDest` — destination account
- `oldbalanceDest` — destination account balance before transaction
- `newbalanceDest` — destination account balance after transaction
- `isFraud` — fraud label
- `isFlaggedFraud` — system-generated fraud flag

## Initial Analytics Focus

The initial analysis will focus on transaction type, transaction amount, fraud concentration, detection rule development, rule performance, and threshold tuning.