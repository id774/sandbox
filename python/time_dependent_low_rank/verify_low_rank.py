# verify_low_rank.py: Verify time-dependent low-rank approximation bounds
#
# Description:
#   Check truncated SVD errors, initial-time rank limitations, and a uniform
#   sufficient rank for a fixed family of time-dependent diagonal matrices.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root with Python 3.12 and NumPy 2.5.0 installed:
#     python3.12 -B python/time_dependent_low_rank/verify_low_rank.py
#
# Requirements:
#   - Python 3.12 or later
#   - NumPy 2.5.0 for the documented reproduction environment
#
# Verified Environment:
#   Tested with Python 3.12.3.

import math

import numpy as np


def truncated_svd(a, rank):
    u, singular_values, vh = np.linalg.svd(a, full_matrices=False)
    approximation = (u[:, :rank] * singular_values[:rank]) @ vh[:rank, :]
    return approximation, singular_values


def truncation_error(a, rank):
    approximation, singular_values = truncated_svd(a, rank)
    reconstruction_error = float(np.linalg.norm(a - approximation, ord="fro"))
    tail_error = float(np.sqrt(np.sum(singular_values[rank:] ** 2)))
    assert np.isclose(reconstruction_error, tail_error, atol=1e-11, rtol=1e-11)
    return reconstruction_error


def minimum_rank(a, epsilon):
    singular_values = np.linalg.svd(a, full_matrices=False, compute_uv=False)
    for rank in range(1, len(singular_values) + 1):
        tail_error = float(np.sqrt(np.sum(singular_values[rank:] ** 2)))
        if tail_error <= epsilon + 1e-12:
            return rank
    raise AssertionError("rank selection failed")


def sufficient_rank(c_t, beta, epsilon, max_rank):
    assert c_t >= 0 and beta > 1 and epsilon > 0 and max_rank >= 1
    estimate = (c_t / ((beta - 1) * epsilon**2)) ** (1 / (beta - 1))
    return min(max_rank, max(1, math.ceil(estimate)))


def main():
    a = np.diag([3.0, 2.0, 1.0])
    print(f"SVD truncation error (D=2): {truncation_error(a, 2):.6f}")

    epsilon = 0.5
    for label, t in [("0", 0.0), ("pi/6", np.pi / 6), ("pi/4", np.pi / 4)]:
        a_t = np.diag([np.cos(t), np.sin(t)])
        error = truncation_error(a_t, 1)
        rank = minimum_rank(a_t, epsilon)
        print(f"t={label:4s}: D=1 error={error:.6f}, min rank={rank}")

    n = 100
    beta = 2.0
    c_t = 4.0
    rank = sufficient_rank(c_t, beta, epsilon, n)
    upper_bound = math.sqrt(c_t / ((beta - 1) * rank ** (beta - 1)))
    print(f"Sufficient rank: {rank}, uniform bound: {upper_bound:.6f}")

    indices = np.arange(1, n + 1, dtype=float)
    for t in np.linspace(0.0, 1.0, 5):
        a_t = np.diag((1.0 + t) / indices)
        error = truncation_error(a_t, rank)
        assert error <= upper_bound + 1e-11
        assert error <= epsilon + 1e-11
        print(f"t={t:.2f}: D={rank} error={error:.6f}")

    a_last = np.diag(2.0 / indices)
    actual_minimum = minimum_rank(a_last, epsilon)
    print(f"Minimum rank for this entire model: {actual_minimum}")


if __name__ == "__main__":
    main()
