# First Fraud Rule Notes

## Objective

Build and evaluate a first baseline fraud detection rule using transaction type and transaction amount.

## Fraud Question

Can a simple rule identify high-risk TRANSFER and CASH_OUT transactions?

## Rule Logic

The rule flags a transaction when:

- Transaction type is `TRANSFER` or `CASH_OUT`
- Transaction amount is greater than or equal to `200,000`

```sql
CASE
    WHEN type IN ('TRANSFER', 'CASH_OUT')
         AND amount >= 200000
    THEN 1
    ELSE 0
END AS rule_flag