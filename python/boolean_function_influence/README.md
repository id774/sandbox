# Boolean Function Influence

## Purpose

This experiment enumerates all `2**N` Boolean inputs for three fixed
functions and compares their variance and maximum squared bit-flip influence
against mathematical formulas. Each family keeps two of the three conditions
(uniformly bounded range, variance bounded away from zero, and fixed degree)
while dropping the remaining condition as `N` increases.

## Requirements

- Python 3.12 or later; the article's reported measurements used Python 3.13.5.
- Python standard library only (`itertools`, `math`); no package installation.

## Run

From the repository root:

```sh
python3 -B python/boolean_function_influence/boolean_influence.py
```

The script accepts no configured inputs or options; it uses fixed odd sizes
`N = 3, 5, 7, 9, 11` and enumerates all inputs under the uniform distribution.
It performs 15 case comparisons (three functions at five sizes), including
range checks and the highest-degree coefficient check for majority. On success,
it prints the following 17 lines, exits with status 0, and writes no files:

```text
N  function     V(calc)    V(theory)   Imax(calc)  Imax(theory)
 3 mean        0.083333     0.083333     0.111111      0.111111
 3 sum         1.000000     1.000000     1.333333      1.333333
 3 majority    0.250000     0.250000     0.500000      0.500000
 5 mean        0.050000     0.050000     0.040000      0.040000
 5 sum         1.000000     1.000000     0.800000      0.800000
 5 majority    0.250000     0.250000     0.375000      0.375000
 7 mean        0.035714     0.035714     0.020408      0.020408
 7 sum         1.000000     1.000000     0.571429      0.571429
 7 majority    0.250000     0.250000     0.312500      0.312500
 9 mean        0.027778     0.027778     0.012346      0.012346
 9 sum         1.000000     1.000000     0.444444      0.444444
 9 majority    0.250000     0.250000     0.273438      0.273438
11 mean        0.022727     0.022727     0.008264      0.008264
11 sum         1.000000     1.000000     0.363636      0.363636
11 majority    0.250000     0.250000     0.246094      0.246094
All checks passed.
```

On a failed numerical or degree check, it raises `AssertionError` and exits
nonzero; earlier output lines may already have been printed. Checks remain
active when Python runs with `-O` because the script uses explicit conditionals.
The computation uses no random input, network access, external input files,
elevated privilege, or third-party packages.

## Functions and Checks

- **Bit mean:** `p_N(x) = sum(x_i)/N` has range `[0, 1]`, degree 1,
  variance `1/(4N)`, and maximum influence `1/N**2`. Its variance tends to zero.
- **Normalized sum:** `g_N(x) = sum(2*x_i-1)/sqrt(N)` has degree 1,
  variance 1, maximum influence `4/N`, and range `[-sqrt(N), sqrt(N)]`.
  The range is not uniformly bounded as `N` increases.
- **Majority:** `m_N(x)` is 1 when a strict majority of bits are 1 and 0
  otherwise. At odd `N`, it has range `{0, 1}`, variance `1/4`,
  maximum influence `comb(N-1,(N-1)//2)/2**(N-1)`, and degree `N`.
  The highest-degree multilinear coefficient is
  `(-1)**((N-1)//2) * comb(N-1,(N-1)//2)`, which is nonzero.

The influence used here is `E[(f(X)-f(X with bit i flipped))**2]` under
the uniform distribution. A `1e-12` relative and absolute tolerance is used
for floating-point comparisons; the majority highest-degree coefficient is
checked with integer equality.

## Limitations

The program explicitly stores `2**N` function values and evaluates all `N`
bit-flip influences, requiring `O(N*2**N)` work and `O(2**N)` storage for
the calculated values. It verifies five finite input sizes. The mathematical
claims about limits as `N` grows follow from the formulas, and these finite
checks do not prove the general influence lower bound for bounded low-degree
polynomials, simulate a quantum circuit, or measure quantum query speedups.
