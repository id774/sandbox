# Agent Handoff Validation

## Purpose

This standalone Python experiment validates structured JSON delivery data
before using it in a fictional 30-day return-window decision. It distinguishes
missing or inconsistent required input (`ValueError`) from a valid delivery
that falls outside the return window (`False`). This is a handoff contract
example, not a running AI agent or a live returns service.

## Requirements

- Python 3.11 or later; the tests were observed passing on Python 3.12.13 and 3.11.15
- Python standard library only (`json`, `re`, `datetime`, `unittest`)
- No external packages, credentials, API calls, network access, or input files

## Files

- `delivery_handoff.py`: parse and validate one delivery JSON message, then
  evaluate the fixed return-window condition.
- `test_delivery_handoff.py`: 11 `unittest` cases using fictional fixed data.

## Run and expected result

From the repository root:

```sh
python3 -B -m unittest discover -s python/agent_handoff_validation -p 'test_*.py' -v
```

All 11 tests must pass and `unittest` must report `OK` with exit status 0.
An assertion failure or uncaught error produces a nonzero exit status.
The elapsed time printed by `unittest` depends on the environment.
There is no separate command-line entry point and no production API.

## Input contract and decision

`within_return_window(message, expected_order_id, requested_at)` accepts a
JSON string, a supplied expected order ID, and a Python `date` for the request.
The decoded JSON must be an object with `order_id`, `delivery_status`, and
`delivered_at`. `order_id` must be a nonblank string equal to the expected ID;
`delivery_status` must equal `delivered`; and `delivered_at` must be a real
calendar date written as `YYYY-MM-DD`.

Missing fields, invalid JSON or values, mismatched order IDs, and a delivery
later than the request date raise `ValueError`. For valid input, the return
value is `True` when elapsed days are between 0 and 30 inclusive, otherwise
`False`. The experiment uses a fixed fictional order `ORD-001`, delivered on
`2026-10-10` and requested for return on `2026-10-25` in the baseline case.

## Fixed tests

- T01: delivery 15 days earlier -> `True`
- T02: delivery on request date -> `True`
- T03: delivery 30 days earlier -> `True`
- T04: delivery 31 days earlier -> `False`
- T05: missing `delivered_at` -> `ValueError`
- T06: null `delivered_at` -> `ValueError`
- T07: invalid date `2026-02-30` -> `ValueError`
- T08: mismatched `order_id` -> `ValueError`
- T09: delivery state `in_transit` -> `ValueError`
- T10: malformed JSON -> `ValueError`
- T11: delivery later than request date -> `ValueError`

## Scope and limits

The 30-day rule is an illustrative assumption and does not authorize a refund.
The tests check only the stated input contract and elapsed-day decision. They
do not establish that the reported delivery date matches an external source,
that a record is current, or that a caller is authorized to issue refunds.
Input size limits and live-service access are also outside this experiment.
No files are read or intentionally written, and no network calls are made.
