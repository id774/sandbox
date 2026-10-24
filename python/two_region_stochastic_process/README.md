# Two-Region Stochastic Process

## Purpose

This experiment simulates two coupled linear stochastic processes with the
Euler-Maruyama method. It compares integrated autocorrelation times and
inter-region correlation estimated from finite observations against continuous-
and discrete-time analytical references. The two parameter sets are hypothetical;
the generated time series are not measured neural data.

## Requirements

- Python 3.12 or later
- NumPy 2.5.4 for the article's specified reproduction environment
- A Linux or macOS shell for the commands below

NumPy is the only third-party runtime dependency. The article's published
output was recorded under Python 3.13.5 and NumPy 2.3.5. It is not a measured
result for Python 3.12 with NumPy 2.5.4.

## Run

From the repository root:

```sh
python3.12 -m venv .venv
.venv/bin/python -m pip install numpy==2.5.4
.venv/bin/python -B python/two_region_stochastic_process/experiment.py
```

The `.venv` directory is ignored by the repository. The script accepts no
command-line options or input files, uses no credentials or network requests,
and does not write data files. It prints results to standard output and exits
with status 0 on success; an uncaught error exits nonzero.

## Experiment and Output

The two parameter sets are `(alpha, beta) = (2.0, 1.0)` and `(4.0, 0.4)`, with
`D = 1.0`, initial state `(0, 0)`, 50 time units discarded as burn-in, and a
self-correlation integration limit of `L = 5`. Time units are abstract and
are not seconds or milliseconds.

For each parameter set, the script uses step sizes `0.02` and `0.01`, observation
durations `200` and `500`, and 20 repetitions per combination. It uses a fixed
base seed of `20261024` and a deterministic offset per condition, step size,
duration, and repetition. The result has two groups and eight numerical rows.

The first line reports the actual Python and NumPy versions. Each group reports
continuous-time `T∞`, finite-integration `TL`, and continuous-time correlation
`S`. The numerical rows report step size, duration, discrete-time `TE`, mean
estimated time scale, its mean absolute error against `TE`, discrete-time `SE`,
mean estimated correlation, and its mean absolute error against `SE`.

`TE` includes Euler discretization and trapezoidal integration at the chosen
step size. `SE` is the stationary correlation of the Euler-discretized process.
The deviations of finite-sample estimates from these discrete references include
sampling variation and estimation effects. Exact displayed sample results can
depend on the Python and NumPy versions; values measured in one environment must
not be represented as measured in another.

## Scope

The sample is a reproducible numerical verification of a hypothetical two-region
model. It does not estimate anesthetic effects, analyze medical datasets, or
infer subjective experience. No separate test framework, saved output, data
fixture, or generated artifact is part of this experiment.

## Source

- [麻酔で共通する神経活動だけでは感じ方を特定できない](https://blog.id774.net/entry/2026/10/15/5764/)
