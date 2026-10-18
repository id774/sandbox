# Agent Context Retention

## Purpose

This standalone Python experiment compares two ways of selecting agent history
records under the same character budget: keeping the newest consecutive records
and retaining records marked as required before adding recent ordinary records.
The comparison measures character reduction, required-record retention, and
exact-text fidelity. The priority flags are fixed input data, not inferred by
an agent or language model.

## Requirements

- Python 3.11 or later
- Python standard library only

## Run

From the repository root:

```sh
python3 -B python/context_retention/context_retention.py
```

The built-in data contains 12 records, four of which are required. The original
joined text is 256 characters, including newline separators. The combined
required records occupy 92 characters. The program compares budgets of 100%,
70%, 50%, and 25% of the original length, rounding each capacity down to an
integer. At the 50% budget, newest-first selection retains 25.0% of required
records, while required-first selection retains 100.0%. At the 25% budget,
required-first selection reports `INFEASIBLE (required records exceed capacity)`.

The program prints a summary table and exits with status 0. An unhandled Python
error exits nonzero. It accepts no command-line arguments, reads no files,
writes no files, and makes no network requests.

## Test

From the repository root:

```sh
python3 -B -m unittest discover -s python/context_retention -p 'test_*.py' -v
```

The six tests check full-budget equivalence, capacity compliance, exact
required-record retention at the feasible minimum, the precise insufficient-
capacity exception, original ordering and text fidelity, and better required-
record retention at the 50% budget. All six tests must pass.

## Selection and Metrics

`length()` counts characters after joining record texts with newline
separators. `recent_first()` adds records newest first and stops on the first
record that would exceed the budget. `required_first()` first reserves every
required record and raises `ValueError("required records exceed capacity")`
if that set exceeds the budget; it then adds ordinary records newest first,
stopping at the first overflow. Selected records retain their original order
and exact text.

`rates()` returns character reduction, required-record retention, and exact-
text fidelity for the fixed input data.

## Limits

Character counts are not token counts or measured API costs. The flags marking
required records are supplied in advance; the experiment does not predict which
facts a real agent will need in a later step. It does not execute a language
model, measure task success, evaluate generated summaries, or reproduce the
CliffCompaction implementation.
