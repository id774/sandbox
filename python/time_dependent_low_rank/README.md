# Time-Dependent Low-Rank Approximation

## Purpose

This experiment compares the rank required by individual time-dependent
matrices with a sufficient rank obtained from a uniform upper bound on their
squared singular values. It uses the best truncated singular value decomposition
(SVD) at each evaluated time and checks absolute Frobenius-norm errors.

## Requirements

The following requirements apply to `verify_low_rank.py`:

- Python 3.12 or later
- NumPy 2.5.0 for reproduction of the documented environment

Create and activate a Python 3.12 virtual environment outside the repository,
then install the single direct dependency:

```sh
python -m pip install 'numpy==2.5.0'
```

## Run

From the repository root in the activated environment:

```sh
python -B python/time_dependent_low_rank/verify_low_rank.py
```

The program takes no arguments or input files, creates no output files, and
has no network or privileged side effects. All matrices and parameters are
fixed in the source. Successful execution returns status 0 and prints:

```text
SVD truncation error (D=2): 1.000000
t=0   : D=1 error=0.000000, min rank=1
t=pi/6: D=1 error=0.500000, min rank=1
t=pi/4: D=1 error=0.707107, min rank=2
Sufficient rank: 16, uniform bound: 0.500000
t=0.00: D=16 error=0.225027
t=0.25: D=16 error=0.281284
t=0.50: D=16 error=0.337541
t=0.75: D=16 error=0.393798
t=1.00: D=16 error=0.450055
Minimum rank for this entire model: 14
```

The numeric display is formatted to six decimal places. Floating-point
rounding may vary in the final displayed digit across other numeric-library
or BLAS environments.

## Model and checks

- A diagonal matrix with singular values `3`, `2`, and `1` has truncation
  error `1` at rank `2`. Each reconstruction error is independently compared
  against the square root of the discarded singular-value squares with
  `atol=1e-11` and `rtol=1e-11`.
- `diag(cos(t), sin(t))` is evaluated at `t=0`, `pi/6`, and `pi/4` with
  absolute error tolerance `epsilon=0.5`. Rank `1` is sufficient at the first
  two times, while rank `2` is needed at `pi/4`.
- For the 100-by-100 diagonal matrix with entries `(1+t)/s` for
  `s=1,...,100` and `0<=t<=1`, the squared singular values satisfy the
  uniform bound `sigma_s(t)^2 <= 4*s^-2`. Here `C_T=4`, `beta=2`, and
  `epsilon=0.5` yield sufficient rank `D=16` and a Frobenius-error upper bound
  of `0.5`.
- The script checks this upper bound at five sampled times, with
  `assert` statements. Its largest actual rank-16 error is `0.450055` at
  `t=1`. The minimum rank for the whole specified matrix family is `14`.

For `beta>1`, the derivation uses the upper bound
`sum_{s>D} sigma_s(t)^2 <= C_T * D^(1-beta)/(beta-1)` and chooses a rank
whose right-hand side is at most `epsilon^2`. The finite family is capped
at its maximum rank of `100`.

## Nuclear norm and fixed-basis comparison

`verify_nuclear_bound.py` measures the squared Frobenius error of the best
rank-one truncated SVD for two fixed 2-by-2 matrix families. It also compares
an analytically certified nuclear-norm rank with the matrix dimension, and
compares a time-updated rank-one approximation with a fixed initial column
space. The script takes no arguments or input files, creates no output files,
and has no network or privileged side effects. Successful execution exits 0.

The documented reproduction environment for this script is Python 3.13.5 and
NumPy 2.3.5. Activate a separate virtual environment outside the repository,
then install its only direct dependency:

```sh
python -m pip install 'numpy==2.3.5'
```

From the repository root, run:

```sh
python -B python/time_dependent_low_rank/verify_nuclear_bound.py
```

Expected output in the documented environment:

```text
A t=0    E1^2=0.000 D_eps=1
A t=pi/6 E1^2=0.250 D_eps=1
A t=pi/4 E1^2=0.500 D_eps=2
nuclear bound: raw=8, capped=2
B t=0    best=0.000 fixed=0.000
B t=pi/4 best=0.000 fixed=0.500
B t=pi/2 best=0.000 fixed=1.000
```

For `A(t) = diag(cos(t), sin(t))` at `0`, `pi/6`, and `pi/4` with
`epsilon = 0.5`, the rank-one squared errors are `0`, `0.25`, and `0.5`,
and the minimum ranks are `1`, `1`, and `2`. Over `0 <= t <= pi/4`, the
maximum squared nuclear norm is `2`. The sufficient-rank estimate is
`ceil(2 / 0.5^2) = 8`, capped at the maximum rank `2` of these matrices.
The value `8` is a sufficient bound before applying the dimension cap,
not the actual minimum rank.

For `B(t) = [[cos(t), 0], [sin(t), 0]]`, the best rank-one squared error is
always zero. Projecting onto the initial column space instead gives squared
errors `0`, `0.5`, and `1` at `0`, `pi/4`, and `pi/2`. These fixed sampled
results do not establish a universal time-uniform guarantee by themselves;
that guarantee depends on the analytical assumptions and inequalities.

## Limitations

The uniform spectral bound is established analytically for this fixed matrix
family. Running SVD at five times does not prove a bound at every time for a
general matrix-valued process. At each sample time, the approximation is
recomputed using that time's singular vectors; fixing the initial basis or
updating only an approximate state requires a separate error analysis.
The experiment does not demonstrate reduced computation time for evolving a
low-rank representation, nor relative-error or operator-norm guarantees.

## Files

- `verify_low_rank.py`: fixed cases, rank selection, numerical checks, and
  formatted verification output.
- `verify_nuclear_bound.py`: nuclear-norm sufficient rank, squared SVD errors,
  and fixed-initial-basis comparison with deterministic formatted output.
