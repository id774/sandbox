# Model Release-Delay Cash Flow Verification

## Purpose

This standalone experiment verifies the month-end cash balances and minimum
liquidity condition for a fixed, fictional three-month AI model release delay.
It also checks the effect of reducing the third month's compute payment.
A financial `FAIL` is an expected result of the scenario, not a Python test
failure.

## Requirements

- Python 3.10 or later
- Python standard library only
- Assertions enabled (do not use `-O`)

## Run

From the repository root:

```sh
python3 -B python/model_release_cash_flow/verification.py
```

Expected standard output:

```text
month=1 balance=77 status=PASS
month=2 balance=49 status=PASS
month=3 balance=16 status=FAIL
```

The process exits with status 0 when all numerical assertions pass. A failed
assertion raises `AssertionError` and exits nonzero. The program accepts no
command-line arguments, reads no external files or environment configuration,
makes no network requests, and intentionally writes no files.

## Fixed Scenario and Checks

All money amounts are in units of 100 million Japanese yen. The starting cash
balance is 100, and the minimum required month-end balance is 30. For each
month, inputs are (cash receipts, compute payments, additional safety
evaluation payments, other payments):

| Month | Receipts | Compute | Evaluation | Other | Expected end balance | Financial status |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| 1 | 20 | 25 | 8 | 10 | 77 | PASS |
| 2 | 15 | 25 | 8 | 10 | 49 | PASS |
| 3 | 10 | 25 | 8 | 10 | 16 | FAIL |

The script checks the three exact balances and statuses. It also asserts the
third-month cash shortfall of 14 and the counterfactual balance of 31 if the
third-month compute payment decreases from 25 to 10. This alternative meets
the minimum balance of 30. The evaluation-payment amounts exclude compute
payments already counted in the compute column.

## Limits

The numbers are fictional and are not Anthropic's actual cash flow. The
example evaluates month-end balances only, not within-month payment timing,
contractual permission to reduce payments, financing conditions, or AI model
safety. The counterfactual assumes the payment reduction is effective within
the third month and creates no offsetting payment during the modeled period.

## Files

- `verification.py`: fixed scenario, exact assertions, counterfactual check,
  and the three output lines from the article.
