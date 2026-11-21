# bell_swap.py: Interleave distant Bell pairs using adjacent SWAP operations
#
# Description:
#   Construct pure multi-qubit Bell-pair states, interleave their qubit order,
#   and check prefix entropy, SWAP counts, depth, and state norms.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     PYTHONOPTIMIZE=0 python -B python/bell_swap_entropy/bell_swap.py
#
# Requirements:
#   - Python 3 interpreter
#   - NumPy 2.3.5
#   - Assertions enabled; do not use -O or -OO.
#
# Verified Environment:
#   Tested with Python 3.13.5 and 3.13.18.

import numpy as np


def bell_pairs_across_halves(n: int) -> np.ndarray:
    if n < 4 or n % 4 != 0:
        raise ValueError('n must be a positive multiple of 4')
    m = n // 2
    state = np.zeros(2**n, dtype=np.complex128)
    for value in range(2**m):
        bits = format(value, f'0{m}b')
        state[int(bits + bits, 2)] = 2**(-m / 2)
    return state


def swap_neighbors(state: np.ndarray, n: int, left: int) -> np.ndarray:
    if not 0 <= left < n - 1:
        raise ValueError('invalid SWAP position')
    axes = list(range(n))
    axes[left], axes[left + 1] = axes[left + 1], axes[left]
    return np.transpose(state.reshape((2,) * n), axes).reshape(-1).copy()


def entropy_of_prefix(state: np.ndarray, n: int, prefix_len: int) -> float:
    amplitudes = state.reshape(2**prefix_len, 2**(n - prefix_len))
    reduced = amplitudes @ amplitudes.conj().T
    eigenvalues = np.linalg.eigvalsh(reduced)
    if eigenvalues.min() < -1e-10:
        raise ArithmeticError('reduced density matrix is not positive')
    positive = np.clip(eigenvalues, 0.0, None)
    positive = positive[positive > 1e-12]
    return float(max(0.0, -np.sum(positive * np.log(positive))))


def interleave_bell_pairs(state: np.ndarray, n: int) -> tuple[np.ndarray, int, int]:
    m = n // 2
    moved = state.copy()
    swaps = 0
    for layer in range(1, m):
        for left in range(m - layer, m + layer - 1, 2):
            moved = swap_neighbors(moved, n, left)
            swaps += 1
    return moved, swaps, m - 1


def main() -> None:
    print('N  swaps depth initial_S(A) final_S(A) norm_before norm_after')
    for n in (4, 8, 12):
        initial = bell_pairs_across_halves(n)
        final, swaps, depth = interleave_bell_pairs(initial, n)
        initial_entropy = entropy_of_prefix(initial, n, n // 2)
        final_entropy = entropy_of_prefix(final, n, n // 2)
        expected_swaps = (n // 2) * (n // 2 - 1) // 2
        expected_depth = n // 2 - 1
        assert swaps == expected_swaps
        assert depth == expected_depth
        np.testing.assert_allclose(np.linalg.norm(initial), 1.0, atol=1e-12)
        np.testing.assert_allclose(np.linalg.norm(final), 1.0, atol=1e-12)
        np.testing.assert_allclose(initial_entropy, n // 2 * np.log(2), atol=1e-12)
        np.testing.assert_allclose(final_entropy, 0.0, atol=1e-12)
        target = np.zeros_like(initial)
        m = n // 2
        for value in range(2**m):
            bits = format(value, f'0{m}b')
            target[int(''.join(bit * 2 for bit in bits), 2)] = 2**(-m / 2)
        np.testing.assert_allclose(final, target, atol=1e-12)
        print(f'{n:2d} {swaps:6d} {depth:5d} {initial_entropy:12.6f} {final_entropy:10.6f} '
              f'{np.linalg.norm(initial):11.6f} {np.linalg.norm(final):10.6f}')


if __name__ == '__main__':
    main()
