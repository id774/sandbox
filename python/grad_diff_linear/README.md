# Linear GradDiff Unlearning

## Purpose

This deterministic NumPy experiment compares GradDiff's forgetting loss with
prediction differences relative to a model retrained on the retained examples.
It reports output RMS separately for the forgotten and retained examples, and
checks the positive-definiteness condition of the quadratic objective.

## Requirements

- Python 3.12
- NumPy 2.2.6
- Python assertions enabled (do not use `-O` or `PYTHONOPTIMIZE`)

## Run

From the repository root, prepare an isolated environment and run the program:

```sh
python3.12 -m venv .venv
. .venv/bin/activate
python -m pip install numpy==2.2.6
python -B python/grad_diff_linear/grad_diff_linear.py
```

The experiment requires no command-line arguments, external datasets, input
files, network access, or intentional file writes. It uses fixed input arrays,
prints its measurements to standard output, and exits with status 0 when the
assertions pass. An assertion failure or unhandled exception exits nonzero;
output from earlier cases may already have been printed.

## Checks and Expected Results

The experiment uses four retained observations, one forgotten observation,
two features, `n = 5`, and L2 coefficient `0.1`. The retraining objective
keeps `n = 5` in its denominator. The displayed forgetting loss is the mean
squared error divided by two per forgotten observation, which differs from
the optimization term's `1 / (2*n)` normalization.

- The all-data model parameters are `[1.88405797, 0.95652174]`.
- The retrained model parameters are `[1.09090909, 1.63636364]`.
- The positive-definiteness boundary is `rho_crit = 55/14`, approximately
  `3.928571`; the six selected coefficients are below it.
- Every selected quadratic matrix has a positive minimum eigenvalue.
- The direct prediction differences agree with the self-leverage and
  cross-leverage expressions within `numpy.allclose` tolerances for both
  forgotten and retained observations.
- At `rho = 1.0`, the forgetting loss is `13.749256`, forgotten-output RMS
  is `1.334812`, and retained-output RMS is `1.167717`.
- Near the boundary, `rho = 3.9` produces forgetting loss `144453.125000`,
  forgotten-output RMS `533.590909`, and retained-output RMS `466.794807`.

Expected standard output, to the script's displayed precision:

```text
theta_all: [1.88405797 0.95652174]
theta_retrained: [1.09090909 1.63636364]
rho_crit: 3.928571
rho   forget_loss   RMS_f       RMS_r       min_eig
0.0      7.640496    0.000000    0.000000    0.329180
0.1      8.044839    0.102103    0.089322    0.323592
0.5     10.031467    0.570076    0.498712    0.300000
1.0     13.749256    1.334812    1.167717    0.267544
3.5    642.013889   31.924242   27.927894    0.047920
3.9   144453.125000   533.590909   466.794807    0.003288
```

## Scope

The program computes exact minimizers of a fixed quadratic GradDiff objective
with L2-regularized linear regression. It is not an iterative gradient-update
training implementation. It does not test a language model, data deletion,
privacy guarantees, generalization to nonlinear models, or optimizer settings.
The two RMS values measure predictions relative to the retrained model, not
prediction error against labels.

The corresponding analysis appears in
[忘却は、再学習との差と保持データへの影響で測る](https://blog.id774.net/entry/2026/11/05/5838/).

## Files

- `grad_diff_linear.py`: the deterministic GradDiff calculation, assertions,
  and tabular numeric output.
