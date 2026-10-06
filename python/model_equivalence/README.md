# Model Equivalence

## Purpose

This sample demonstrates how to compare two deterministic numerical model
implementations through shared observations rather than through their internal
code structure.

It uses exact equality for discrete values, tolerance-based comparison for
floating-point values, fixed scenarios for path-by-path comparison, and
independent invariants that do not treat either implementation as the reference
answer.

## Requirements

- Python 3.10 or later
- pytest

Install pytest with the normal Python package installation mechanism for the
environment being used. No project-specific package manifest is required for
this sample.

## Run

From this directory:

```sh
python -m pytest -q
```

A successful run collects and passes 7 tests.

## What the tests verify

- Contract IDs and year numbers match exactly.
- Floating-point observations match within `rel=1e-9` and `abs=1e-12`.
- Three fixed scenarios compare the old and new implementations year by year.
- Each implementation independently satisfies the fee, balance, and present
  value invariants.
- A shared present-value bug can pass the old-versus-new comparison while the
  invariant check still detects the inconsistency.

## Files

- `model.py`: the two deterministic model implementations and their shared
  result structures.
- `test_model.py`: the exact, tolerance-based, scenario, and invariant tests.
