# Migration Judge Validation

## Purpose

This standalone experiment compares three old-new comparison judges using
fixed observations from Python child processes. It measures false acceptance
and false rejection against an independently specified input/output contract.
The deliberately incomplete judges expose the effect of omitted checks; the
contract-aware judge is evaluated on the same cases.

## Requirements

- Python 3.10 or later
- Python standard library only (`json`, `math`, `subprocess`, `sys`,
  `dataclasses`, and `unittest`)
- A local environment that can launch Python child processes and complete
  normal fixtures within the one-second timeout
- No external packages, credentials, input files, or network access

Python 3.10 is the minimum version required by the `int | None` union type
annotation used in the implementation.

## Verified Environment

The experiment and 16 tests were run with Python 3.13.5 on Debian GNU/Linux 13
(x86_64). Execution with Python 3.10 and on macOS has not been verified.

## Files

- `migration_judge_validation.py`: fixed fixtures, process observations, three
  judges, confusion counts, metrics, and printed results.
- `test_migration_judge_validation.py`: 16 `unittest` methods.

## Run

From this directory:

```sh
python3 --version
python3 -B migration_judge_validation.py
python3 -B -m unittest -v test_migration_judge_validation.py
```

The experiment uses fixed data and has no command-line options or external
input files. Each fixture reads and discards the same standard input, emits
prescribed bytes, and exits with the specified status. The delayed fixture
flushes its output and waits three seconds; observation uses a one-second
timeout. The same observations are passed to all three judges. An unexpected
observation raises `RuntimeError` before evaluation; process startup errors
propagate. A normal experiment exits with status 0 even when A or B produces
intentional misclassifications. An uncaught error exits nonzero. A successful
test run reports 16 tests and `OK` with exit status 0. Test failures or errors
produce a nonzero exit status. Elapsed time depends on the environment.

## Comparison contract

A strips leading and trailing whitespace from stdout and compares the bytes.
B uses A for raw data and standard `json.loads()` equality for JSON. A and B
ignore exit status, stderr, and timeout state. C rejects timed-out or missing
exit-status observations, compares exit status and stderr exactly, and uses
byte equality for raw stdout. For JSON, C decodes UTF-8, rejects duplicate
object keys and non-finite numbers (including overflow to infinity), and
recursively compares the parsed Python types and values. Object key order is
irrelevant; array order and length are preserved. Integers, booleans, strings,
and null are compared exactly after type checks. Finite floats use
`math.isclose()` with `rel_tol=1e-9` and `abs_tol=1e-12`. Identical nonzero
exit codes and matching output can be accepted. Unknown modes in C raise
`ValueError` after its process-state checks; invalid JSON or recursion errors
are rejected. These conditions define the experiment's contract.

## Fixed cases

| ID | Change | Expected |
| --- | --- | --- |
| P01 | Identical raw bytes | Accept |
| P02 | JSON object key order | Accept |
| P03 | JSON structural whitespace | Accept |
| P04 | `1.0` to `1.0000000005` | Accept |
| P05 | `0.0` to `5e-13` | Accept |
| P06 | Same error output and exit code 2 | Accept |
| N01 | Remove significant trailing space | Reject |
| N02 | Exit code 0 to 1 | Reject |
| N03 | Change stderr | Reject |
| N04 | Missing JSON key | Reject |
| N05 | `true` to `1` | Reject |
| N06 | `1` to `1.0` | Reject |
| N07 | `9007199254740993` to `9007199254740992` | Reject |
| N08 | `1.0` to `1.01` | Reject |
| N09 | `1.0` to `NaN` | Reject |
| N10 | `1.0` to `Infinity` | Reject |
| N11 | Duplicate JSON key with the original last value | Reject |
| N12 | Timeout after identical stdout | Reject |
| N13 | `1.0` to `1e400` | Reject |
| N14 | Invalid UTF-8 in JSON | Reject |
| N15 | Reordered JSON array | Reject |

## Expected results

The positive class is contract compliance. TP and TN count correct acceptance
and rejection; FP and FN count false acceptance and false rejection. The false
acceptance rate is FP / (FP + TN), the false rejection rate is FN / (FN + TP),
and accuracy is (TP + TN) / 21 for these fixed cases.

```text
ID  expected A B C
P01 1        1 1 1
P02 1        0 1 1
P03 1        0 1 1
P04 1        0 0 1
P05 1        0 0 1
P06 1        1 1 1
N01 0        1 1 0
N02 0        1 1 0
N03 0        1 1 0
N04 0        0 0 0
N05 0        0 1 0
N06 0        0 1 0
N07 0        0 0 0
N08 0        0 0 0
N09 0        0 0 0
N10 0        0 0 0
N11 0        0 1 0
N12 0        1 1 0
N13 0        0 0 0
N14 0        0 0 0
N15 0        0 0 0
A: TP,TN,FP,FN=(2, 11, 4, 4); FAR=26.67% FRR=66.67% accuracy=61.90%
B: TP,TN,FP,FN=(4, 8, 7, 2); FAR=46.67% FRR=33.33% accuracy=57.14%
C: TP,TN,FP,FN=(6, 15, 0, 0); FAR=0.00% FRR=0.00% accuracy=100.00%
```

| ID | Check | Expected result |
| --- | --- | --- |
| V01 | Normal process | Exact observation |
| V02 | Abnormal exit | Preserve code 1 and reject |
| V03 | Stderr and matching error | Reject N03, accept P06 |
| V04 | Timeout | Flag set, code absent, stdout retained, reject |
| V05 | Significant whitespace | Accept P01, reject N01 |
| V06 | JSON format | Accept P02 and P03 |
| V07 | Missing key | Reject N04 |
| V08 | Array order | Reject N15 |
| V09 | Type changes | Reject N05, N06, and nested boolean-to-int change |
| V10 | Large integers | Reject N07 |
| V11 | Float tolerance | Accept P04, P05 and absolute boundary; reject N08 and beyond-boundary value |
| V12 | Non-finite values | Reject N09, N10, N13, negative infinity, and all four direct parser inputs |
| V13 | Duplicate key | Reject N11 |
| V14 | Encoding | Reject N14 and equivalent UTF-16 and UTF-32 JSON |
| V15 | Metrics | Match 4/15, 4/6, and 13/21 |
| V16 | All cases | Match every acceptance set and all confusion counts |

## Mutation checks

The parser checks in V12 and V14 also detect defects in the judge itself.
To reproduce this, make two independent temporary copies of both Python files
outside the repository. In the first copy remove only
`parse_constant=reject_constant, parse_float=finite_float,` from `strict_loads`.
Run `python3 -B -m unittest -v test_migration_judge_validation.JudgeTest.test_v12_nonfinite`
from that copy. The expected result is four subtest failures reporting
`ValueError not raised` and a nonzero exit status. In the second copy replace
only `data.decode('utf-8')` with `data` in `strict_loads` and run
`python3 -B -m unittest -v test_migration_judge_validation.JudgeTest.test_v14_utf8`.
The expected result is two subtest failures reporting `True is not false` and a
nonzero exit status. Discard both copies after checking. The original code
and tests must remain unchanged. These failures are expected evidence of
mutation detection, not failures of the original implementation.

## Scope and limits

The results describe the 21 fixed cases, not a general detection rate for
unknown defects. The child processes emit prescribed observations rather than
implementing business logic. The experiment does not verify database updates,
file changes, network effects, or the correctness of the old implementation.
The float contract does not preserve exact decimal precision, underflow, or
signed zero, and tolerance-based equality is not generally transitive.
Compare each candidate directly against its baseline. A timeout depends on
process startup and machine load; an unexpected observation invalidates the
run rather than changing the expected decision. The experiment is not an
isolation mechanism for executing untrusted code.
