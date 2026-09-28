# Temporal Memory State

## Purpose

This sample keeps the history of state values in SQLite and reconstructs the
state that was valid at a given time from each row's validity interval.

## Requirements

- Python 3.12 or later
- pytest for running the tests
- The runtime code uses only the Python standard library.

## Model

- Key: `(subject, attribute)`
- Value: `value`
- Validity: `[valid_from, valid_to)`, in UTC Unix time
- `valid_to = NULL` means the interval is open-ended.
- Old rows are retained rather than deleted.
- `as_of()` selects the row valid at the requested time.

## Run

From the `python/temporal_memory` directory:

```sh
python -m pytest -q
```

## Observable Behavior

- Later values close the previous open interval without deleting it.
- `as_of()` reconstructs past or current state by timestamp.
- `current()` uses the same rule with the current or supplied time.
- `revoke()` closes an interval while preserving history.
- Out-of-order history insertion is rejected.

## Files

- `memory_history.py`: SQLite-backed temporal state history
- `test_memory_history.py`: deterministic tests for replacement, past lookup,
  revocation, future activation, and insertion order
