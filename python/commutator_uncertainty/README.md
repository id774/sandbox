# Commutator Uncertainty Residual

## Purpose

This experiment evaluates the difference between the variance product and the
Robertson-Schrodinger lower bound for fixed two- and three-dimensional quantum
states. It computes the residual directly from matrix products and compares it
with a state-dependent squared-commutator lower bound.

## Requirements

- Python 3.12 or later
- Python standard library only

## Run

From the repository root:

```sh
python3 -B python/commutator_uncertainty/commutator_uncertainty.py
```

Successful execution exits with status 0 and prints exactly:

```text
case                purity    residual  lower_bound
qubit-mixed-max      0.500000    1.000000     1.000000
qubit-mixed          0.625000    0.750000     0.750000
qubit-pure           1.000000    0.000000     0.000000
qutrit-equality      0.500000    0.111111     0.111111
qutrit-strict        0.500000    0.277778     0.069444
```

Run the seven standard-library unit tests from the experiment directory:

```sh
cd python/commutator_uncertainty
python3 -B -m unittest -v test_commutator_uncertainty
```

Successful tests exit with status 0 and report seven passing tests. A failed
assertion or an unhandled exception gives a nonzero exit status. No input files,
command-line arguments, network operations, or output files are used.

## Model and Checks

For Hermitian matrices `A` and `B` and density matrix `rho`, the residual is
`D = V(A) * V(B) - Cov(A, B)^2 - abs(Tr(rho * [A, B]))^2 / 4`.
The state-dependent lower bound is
`b * Tr(rho * [A, B].conj().T * [A, B])`, where the coefficient `b` is
`lambda_1 * lambda_2 / (lambda_1 + lambda_2)` for the two smallest positive
ordered eigenvalues of a full-rank state and is zero when the smallest
eigenvalue is zero.

The implementation uses direct complex matrix arithmetic without a numerical
linear-algebra library. Eigenvalues are supplied explicitly for the fixed
diagonal states; no general eigensolver is implemented.

The five printed cases establish the following calculations:

- The completely mixed qubit has zero commutator expectation, residual 1, and
  lower bound 1, despite a nonzero commutator.
- A mixed qubit with eigenvalues `3/4` and `1/4` has residual and bound `3/4`.
- A pure qubit has residual and bound zero.
- A qutrit with eigenvalues `1/6`, `1/6`, and `2/3`, using two observables
  acting on the first two levels, attains residual and bound `1/9`.
- The same qutrit using observables on the first and second level pairs has
  residual `5/18`, exceeding the bound `5/72`.

The unit tests additionally check that two qutrit states have equal purity
`1/2` while their coefficients are `1/12` and zero, that commuting observables
have zero commutator norm and zero residual, and that the fixed mixed-qubit
residual equals `2 * (1 - purity)` for the selected Pauli observables.

## Limitations

These fixed numerical examples do not constitute a proof for arbitrary density
matrices or observables. The program does not compute eigenvalues for general
states, perform symbolic algebra, or evaluate measurement outcomes. Displayed
values use six decimal places; the tests check unrounded floating-point values.

## Files

- `commutator_uncertainty.py` contains matrix operations and fixed-case output.
- `test_commutator_uncertainty.py` contains seven `unittest` cases.
