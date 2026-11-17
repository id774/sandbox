# Bell Pair SWAP Entropy

## Purpose

This standalone Python experiment constructs Bell pairs between the left and
right halves of a pure qubit state, then uses adjacent SWAP operations to
interleave their positions. It checks that the whole state remains normalized
while the von Neumann entropy of the left half falls from `m * log(2)` to zero,
where `N = 2 * m` is the total number of qubits.

## Requirements

- Python 3.13 (reference execution: Python 3.13.5).
- NumPy 2.3.5; this is the only third-party runtime dependency.
- Assertions enabled (`PYTHONOPTIMIZE=0`, without `-O` or `-OO`).

## Run

From the repository root:

```sh
python3.13 -m venv .venv
. .venv/bin/activate
python -m pip install numpy==2.3.5
python --version
python -c "import numpy; print(numpy.__version__)"
PYTHONOPTIMIZE=0 python -B python/bell_swap_entropy/bell_swap.py
```

The reference version commands report Python `3.13.5` and NumPy `2.3.5`.
Successful experiment execution exits with status 0 and prints exactly:

```text
N  swaps depth initial_S(A) final_S(A) norm_before norm_after
 4      1     1     1.386294   0.000000    1.000000   1.000000
 8      6     3     2.772589   0.000000    1.000000   1.000000
12     15     5     4.158883   0.000000    1.000000   1.000000
```

The program uses fixed cases without arguments, standard input, input data
files, network requests, or intentional output files. Installation of NumPy
requires package access at setup time; the experiment itself runs offline.
A missing NumPy installation stops execution with an import error. A failed
assertion or another unhandled exception produces a nonzero exit status.
Importing the module does not run the experiment or print these results.

## Model and Checks

For `N` in `(4, 8, 12)` and `m = N // 2`, the initial state has a Bell pair
between each pair of positions `(i, i + m)` for `0 <= i < m`. Its amplitudes
are `2**(-m / 2)` at basis strings consisting of the same `m` bits twice and
zero elsewhere. The state uses `complex128` and has norm 1.

The interleaving operation transforms the order
`a0, ..., a(m-1), b0, ..., b(m-1)` into
`a0, b0, a1, b1, ..., a(m-1), b(m-1)` by swapping adjacent tensor axes.
Layer `k`, for `k = 1, ..., m - 1`, has `k` pairwise disjoint SWAPs. Thus the
specified procedure uses `m * (m - 1) // 2` SWAPs and depth `m - 1`.

`entropy_of_prefix` reshapes the state into a bipartite amplitude matrix `M`,
forms the reduced density matrix `M @ M.conj().T`, and uses its Hermitian
eigenvalues to evaluate `-sum(p * log(p))` for positive eigenvalues. Values
below `-1e-10` raise `ArithmeticError`. Eigenvalues are clipped to zero and
values at or below `1e-12` are omitted from the logarithm.

The embedded assertions check the exact integer SWAP count and depth, initial
and final state norms of 1, initial entropy `m * log(2)`, final entropy zero,
and equality with an independently constructed state of adjacent Bell pairs.
`numpy.testing.assert_allclose` explicitly uses `atol=1e-12` and the NumPy
2.3.5 default `rtol=1e-7`. Invalid qubit counts (`n < 4` or `n % 4 != 0`)
and invalid neighboring SWAP indices raise `ValueError`, as implemented.

## Limitations

The experiment checks a fixed adjacent-SWAP arrangement for three finite,
pure quantum states. It does not establish a lower bound for arbitrary
rearrangement algorithms. Gate depth becomes physical elapsed time only after
specifying a per-layer duration and a parallel-execution model. Prefix von
Neumann entropy is distinct from quantum macroscopic entropy density. The
example does not establish thermodynamic equilibrium, work extraction, a
relaxation process, or a thermodynamic-limit second-law result.

## Files

- `bell_swap.py` contains the state construction, adjacent SWAP operations,
  reduced-state entropy computation, embedded assertions, and fixed output.
