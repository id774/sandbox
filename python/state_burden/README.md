# State Burden

## Purpose

This standalone Python experiment compares changes in an internal state with
the level of burden produced by that state and a constant external stimulus.
It demonstrates that a vanishing state change does not imply a vanishing
burden. Four deterministic scenarios distinguish decay, preservation of an
initial state, a forced fixed point, and saturation.

## Requirements

- Python 3.12 or later. The original sample was run with Python 3.13.5.
- Python standard library only (`dataclasses`, `math`, and `unittest`).
- No installation of external packages, external input files, network access,
  or elevated privileges.

## Run

From `python/state_burden`:

```sh
python3 -B state_burden.py
python3 -B -m unittest -v test_state_burden
```

The sample program prints the following five lines and exits with status 0.

```text
case          q_100        A_100        B_100        settled acceptable accepted
decay        0.000013281  0.000001476  0.000013281  True    True       True
fixed        0.500000000  0.000000000  0.500000000  True    False      False
forced       0.400002656  0.000000295  0.600002656  True    False      False
saturation   1.000000000  0.000000000  1.000000000  True    False      False
```

The test command runs seven test methods and exits with status 0 when all
pass. The `unittest` runner reports the results and `OK` on standard error.
Its elapsed time varies by environment. A failed test or unhandled exception
exits nonzero. The sample takes no command-line options, reads no files or
standard input, and makes no network requests or intentional file writes.
Importing `state_burden` does not print the sample output.

## Model and Checks

The internal state `q` is a nonnegative scalar, and `p` is a constant
nonnegative external stimulus. The model has no intervention. The natural
decay rate `delta` is between 0 and 1, the update rate `eta` is nonnegative,
and the coefficients `kappa` and `beta` are positive. The update coefficient
is `rho = 1 + (eta * kappa - delta)`. The next state is
`rho * q + eta * p`, capped at `q_max` when an upper bound is supplied.
The saturation case uses a positive initial state and a positive upper bound.
The experiment assumes these input conditions and nonnegative integer step
counts rather than validating every argument.

`Case` and `Sample` are frozen dataclasses. `update_state` computes the next
state, and `measure_burden` returns `beta * (p + kappa * q)`. `simulate`
returns a list containing the initial sample and one sample per update.
Each sample records `(t, q, amplitude, burden)`. Amplitude is the absolute
change from the previous state. At time 0 it is `None`; `evaluate` raises
`ValueError('amplitude is undefined at t=0')` for such a sample.

The four cases use `q0 = 0.5`, `eta = 0.2`, `kappa = beta = 1.0` and 100
updates. The remaining parameters and theoretical limits are:

| Case | delta | rho | p | q_max | Limit of q | Limit of burden |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| decay | 0.3 | 0.9 | 0.0 | None | 0.0 | 0.0 |
| fixed | 0.2 | 1.0 | 0.0 | None | 0.5 | 0.5 |
| forced | 0.3 | 0.9 | 0.2 | None | 0.4 | 0.6 |
| saturation | 0.1 | 1.1 | 0.0 | 1.0 | 1.0 | 1.0 |

For decay, the analytical state is `0.5 * 0.9**t`. For fixed, it is 0.5.
For forced, it is `0.4 + 0.1 * 0.9**t`. For saturation, it is
`min(1.0, 0.5 * 1.1**t)`. The amplitudes approach zero in every case.
Saturation reaches the upper bound at step 8, and its amplitude becomes
zero at step 9.

`evaluate` returns `(settled, acceptable, accepted)`. The first flag checks
whether amplitude is at most `1e-4`; the second checks whether burden is at
most `1e-4`. The third is their conjunction. At step 100 all cases meet the
amplitude threshold, but only decay meets the burden threshold. The flags
are measurements of the defined conditions, not process exit statuses.
The sample always runs 100 updates per case rather than stopping on a flag.

For decay, amplitude first meets its threshold at step 60, with burden about
0.000899. Burden first meets its threshold at step 81. Stopping solely at the
first amplitude threshold crossing can therefore precede acceptance even
when burden eventually tends to zero.

## Validation

`test_state_burden.py` contains seven standard-library unit tests. They check
initial samples and the undefined-amplitude exception, all 101 time indices,
analytical state, amplitude and burden values for the four cases, saturation
at steps 8 and 9, and the expected independent flags at step 100. The fixed
case checks exact values. Analytical floating-point comparisons use
`math.isclose` with relative and absolute tolerances of `1e-12`, independent
of the model's `1e-4` acceptance thresholds.

## Limitations

The experiment assumes constant inputs, a fixed scalar update rule, and
an optional upper bound. A small amplitude at a finite time does not prove
asymptotic convergence. The analytical solutions justify the limits under
the stated assumptions. The burden is a model quantity, not measured data,
and the thresholds are illustrative. The experiment does not establish
quality, safety, or acceptable burden for a real system. Time-varying
inputs, multivariate states, intervention design, and parameter estimation
are outside its scope.

## Files

- `state_burden.py`: state updates, samples, burden, independent flags, and
  the fixed four-case demonstration.
- `test_state_burden.py`: seven unit tests of the implementation and model.
