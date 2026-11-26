# Agent Workflow Reliability

## Purpose

This standalone Python experiment evaluates the probability of completing a
fixed sequence of stages, with at most one repair attempt per stage. It
compares analytical probabilities with seeded Monte Carlo simulations and
calculates the stage success rate and recovery rate needed to reach a target
workflow success probability.

## Requirements

- Python 3 interpreter with `dataclasses` and `math.prod`
- Python standard library only (`dataclasses`, `math`, `random`, `unittest`)
- No external packages, credentials, input files, or network access

## Verified Environment

Tested with Python 3.13.5. Use this version to reproduce the recorded results.

## Files

- `agent_workflow_reliability.py`: analytical probability calculations,
  simulation, and fixed experiment output.
- `test_agent_workflow_reliability.py`: 16 `unittest` cases.

## Run

From the repository root:

```sh
python3 --version
python3 -B python/agent_workflow_reliability/agent_workflow_reliability.py
python3 -B -m unittest discover -s python/agent_workflow_reliability -p 'test_*.py' -v
```

Run with Python assertions enabled. The experiment uses fixed parameters,
accepts no command-line options or input files, writes no data files, and
makes no network requests. Both the experiment and tests exit with status 0
on success. An assertion failure or uncaught error exits nonzero. The elapsed
time printed by `unittest` depends on the environment.

## Model and experiment

`Stage(q, d, r)` specifies the initial success probability `q`, the detection
probability `d` conditional on initial failure, and the repair success
probability `r` conditional on detected failure. All probabilities are in
[0, 1]; `d` and `r` default to 0. The effective stage success probability is
`q + (1 - q) * d * r`. The product of the effective stage success probabilities
is the workflow success probability. Stage probabilities are conditional on
prior stages having succeeded, including recovery when applicable.

`run_once` draws initial success first. On failure it draws detection, then
repair only if the failure was detected. It stops at the first unrecovered
failure and returns `False`; otherwise it returns `True`. `simulate` returns
the successful trial count and uses a fresh `Random(seed)` for each condition.
`required_stage` returns `target ** (1 / n)`. `required_recovery` returns 0
when initial success meets that requirement, otherwise the additional
required recovery probability conditional on initial failure. The fixed
model rejects invalid probabilities and nonpositive or noninteger counts
through `ValueError` in the applicable functions.

Each of the 30 conditions runs 100,000 trials with seed 42:

- `baseline`: 15 combinations of 1, 5, 10, 20, or 50 stages and initial
  success probabilities 0.90, 0.95, or 0.99, without recovery.
- `recovery`: 12 combinations of detection probabilities 0, 0.8, or 1 and
  repair probabilities 0, 0.5, 0.9, or 1, with 20 stages and initial success
  probability 0.95.
- `heterogeneous`: 20 stages at 0.99; 19 stages at 0.99 and a final stage at
  0.80; and the same final stage with detection 0.8 and repair 0.9.

The output has a pipe-delimited header followed by 30 rows with group,
condition, theoretical probability, success count, observed probability,
absolute error, and five standard errors. Every row must satisfy the
five-standard-error bound `5 * sqrt(p * (1 - p) / trials)`, with the
implementation's `1e-15` allowance for the assertion. The last two lines
report required stage and recovery probabilities for a target of 0.95 over
20 stages, with initial stage success 0.95 for the recovery calculation.

## Expected results

Representative results verified with Python 3.13.5:

| Condition | Theoretical probability | Successes | Observed probability |
| --- | ---: | ---: | ---: |
| 20 stages at 0.95, no recovery | 0.35848592 | 35979 | 0.35979000 |
| 20 stages at 0.95, detection 0.8, repair 0.9 | 0.75428991 | 75439 | 0.75439000 |
| 20 stages at 0.95, detection 1, repair 1 | 1.00000000 | 100000 | 1.00000000 |
| 20 stages at 0.99 | 0.81790694 | 81911 | 0.81911000 |
| Final stage at 0.80 | 0.66093490 | 66227 | 0.66227000 |
| Final stage at 0.80 with recovery | 0.77990318 | 78053 | 0.78053000 |

The last two lines are:

```text
required_stage=0.99743862
required_recovery=0.94877242
```

All 16 tests must pass with `OK`, zero failures, zero errors, zero skips,
and exit status 0.

| ID | Case | Expected result |
| --- | --- | --- |
| V01 | Single stage | 0.95 |
| V02 | Uniform stage probabilities | 0.95 ** 20 |
| V03 | Heterogeneous probabilities | 0.72 |
| V04 | Zero initial success without recovery | Probability 0, 0 of 100 successes |
| V05 | Certain initial success | Probability 1, 100 of 100 successes |
| V06 | Zero detection | 0.95 |
| V07 | Zero repair success | 0.95 |
| V08 | Perfect recovery from initial failure | Probability 1, 100 of 100 successes |
| V09 | Partial recovery | 0.986 |
| V10 | Required stage probability | Reconstructed target 0.95 |
| V11 | Required recovery probability | Reconstructed target 0.95, zero when recovery is unnecessary |
| V12 | Invalid probabilities | `ValueError` |
| V13 | Invalid stage or trial counts | `ValueError` |
| V14 | Four controlled execution paths | Expected Boolean results and exact draw consumption |
| V15 | Fixed-seed reproducibility | Equal counts |
| V16 | Simulation versus theory | Error within five standard errors |

## Scope and limits

The simulation uses supplied probabilities, not measurements of actual
language models or agents. It treats the true outcome of a stage as known
when counting a failed trial, even if detection fails. It assumes that repair
preserves successful prior stages, that recovery history does not change
later stage parameters, and that successful results are not misclassified
as failures. It does not model repeated retries, cross-stage repair, false
positives, correlated trial outcomes, repair side effects, or access-control
guarantees. The five-standard-error bound is a diagnostic for the stipulated
simulation, not a rigorous confidence interval or a guarantee of real-world
reliability.
