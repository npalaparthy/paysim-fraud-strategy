# SQL Analysis Notes

## Objective

Validate fraud concentration by transaction type using SQL.

## Fraud Question

Which transaction types have the highest fraud concentration?

## SQL Logic

The analysis groups transactions by `type` and calculates:

- Total transactions
- Fraud transactions
- Fraud rate

Fraud rate is calculated as:

```sql
SUM(isFraud) * 1.0 / COUNT(*)