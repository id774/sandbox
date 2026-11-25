# Joint-Observation Information Leakage

## Purpose

This experiment compares information leakage from individual observations
with leakage from their joint distribution. A pair of observations may reveal
information about a synthetic attribute even when each observation is
independent of it. Repeated information can also make the sum of individual
mutual information values exceed the joint value.

## Requirements

- Python 3.9 or later (the test uses dictionary union).
- Python standard library only.
- No external packages, network access, external data, or installation step.

## Verified Environment

Tested with Python 3.13.5.

## Run

From the repository root:

```sh
python3 -B python/joint_observation_leakage/leakage_audit.py
```

The program requires no arguments and reads or writes no data files. It
prints a header and four cases to standard output, in C01 through C04 order.
Successful execution exits with status 0. An unhandled exception exits
nonzero. Invalid numeric probability distributions passed to `evaluate()`
or `validate_distribution()` raise `ValueError` for the conditions below.

## Fixed Data and Calculation

The three binary variables are a synthetic attribute A and observations Z1
and Z2. The following weights are divided by 8 to obtain the joint
probability distribution. Each distribution has eight states and sums to 1.
The attribute has equal prior probabilities and entropy 1 bit in every case.

| A | Z1 | Z2 | C01 | C02 | C03 | C04 |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 0 | 0 | 0 | 1 | 2 | 2 | 4 |
| 0 | 0 | 1 | 1 | 2 | 0 | 0 |
| 0 | 1 | 0 | 1 | 0 | 0 | 0 |
| 0 | 1 | 1 | 1 | 0 | 2 | 0 |
| 1 | 0 | 0 | 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 0 | 2 | 0 |
| 1 | 1 | 0 | 1 | 2 | 2 | 0 |
| 1 | 1 | 1 | 1 | 2 | 0 | 4 |

C01 is independent; C02 reveals the attribute through the first observation
only; C03 reveals it through the joint observation only; C04 contains the
same attribute information in both observations.

The program sums over omitted axes to obtain marginal distributions and
computes Shannon entropy as the negative sum of `p * log2(p)` over positive
probabilities. It uses `H(A) + H(Z) - H(A,Z)` for mutual information and
`H(A,Z1) + H(Z1,Z2) - H(Z1) - H(A,Z1,Z2)` for conditional mutual information
of A and Z2 given Z1. The chain rule gives joint leakage as first-observation
leakage plus additional leakage. All information values are in bits.

The calculation uses disjoint tuples of axes selected from 0 (A), 1 (Z1),
and 2 (Z2). `evaluate()` validates the distribution before calculating the
four values. Numerical comparisons use absolute tolerance `1e-12`, with
zero relative tolerance for normalization. This tolerance is not a privacy
policy threshold.

## Expected Output

The exact standard output measured with Python 3.13.5 is:

```text
case  I(A;Z1)  I(A;Z2)  joint  additional  sum
C01   0.000    0.000    0.000    0.000       0.000
C02   1.000    0.000    1.000    0.000       1.000
C03   0.000    0.000    1.000    1.000       0.000
C04   1.000    1.000    1.000    0.000       2.000
```

The `joint` column is joint mutual information, `additional` is the
conditional mutual information given the first observation, and `sum` is
the sum of the two individual values. C03 underestimates joint leakage by
1 bit when only the individual values are added. C04 overestimates it by
1 bit under the same calculation.

## Test

From this directory:

```sh
python3 -B -m unittest -v
```

A successful run passes all nine tests and exits with status 0.

| Test | Expected result |
| --- | --- |
| V01 | All four distributions sum to 1 |
| V02 | Equal prior probabilities and attribute entropy 1 bit |
| V03 | C01: (0, 0, 0, 0) |
| V04 | C02: (1, 0, 1, 0) |
| V05 | C03: (0, 0, 1, 1) |
| V06 | C04: (1, 1, 1, 0) |
| V07 | Joint mutual information equals first plus additional leakage |
| V08 | Each of the four information values lies between 0 and prior entropy, within tolerance |
| V09 | Seven invalid distributions raise ValueError |

The tuple order is first, second, joint, and additional mutual information.
V09 covers a missing state, a state outside the binary domain, a negative
probability, NaN, infinity, a probability above 1, and an incorrect sum.

## Interpretation and Limits

The inputs are fixed synthetic probability distributions, not actual
messages or samples from a language model. The experiment demonstrates
properties of known distributions and does not estimate an unknown
population distribution, identify a real person, implement a covert
communication mechanism, or establish privacy guarantees for a deployed
system. For a real audit, observations must be associated with the same
subject and recipients who can combine them. The model here corresponds to
constant prior knowledge; varying recipient knowledge requires a larger
state space. Authorization to disclose information is distinct from actual
receipt. Finite-sample estimation error and unobserved features remain
outside the calculation.

## Files

- `leakage_audit.py`: four fixed distributions and their information measures.
- `test_leakage_audit.py`: nine deterministic standard-library unit tests.
