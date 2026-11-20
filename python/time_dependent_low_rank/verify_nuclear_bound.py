# verify_nuclear_bound.py: Verify nuclear rank bounds and basis-rotation errors
#
# Description:
# Check squared truncated SVD errors, an analytically capped sufficient rank
# from a nuclear-norm bound, and errors from fixing the initial column space.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
# From the repository root in an environment with Python 3.13.5 and NumPy 2.3.5:
#   python -B python/time_dependent_low_rank/verify_nuclear_bound.py
#
# Requirements:
# Python 3.13.5 for the documented reproduction environment
# NumPy 2.3.5 for the documented reproduction environment

import numpy as np

EPS = 0.5
TIMES = [0.0, np.pi / 6, np.pi / 4]


def a(t):
    return np.diag([np.cos(t), np.sin(t)])


def b(t):
    return np.array([[np.cos(t), 0.0], [np.sin(t), 0.0]])


def truncation_error2(matrix, rank):
    u, s, vh = np.linalg.svd(matrix, full_matrices=False)
    approx = (u[:, :rank] * s[:rank]) @ vh[:rank, :]
    return float(np.linalg.norm(matrix - approx, ord="fro") ** 2)


def minimum_rank(matrix, epsilon):
    s = np.linalg.svd(matrix, compute_uv=False)
    for rank in range(len(s) + 1):
        if np.sum(s[rank:] ** 2) <= epsilon**2:
            return rank
    raise RuntimeError("No feasible rank")


for label, t in zip(["0", "pi/6", "pi/4"], TIMES):
    e2 = truncation_error2(a(t), 1)
    d = minimum_rank(a(t), EPS)
    print(f"A t={label:4s} E1^2={e2:.3f} D_eps={d}")

l_max_sq = 2.0  # Squared maximum nuclear norm over [0, pi/4].
unclipped = int(np.ceil(l_max_sq / EPS**2))
certified = min(2, unclipped)
print(f"nuclear bound: raw={unclipped}, capped={certified}")

initial_basis = np.array([[1.0], [0.0]])
p0 = initial_basis @ initial_basis.T
for label, t in zip(["0", "pi/4", "pi/2"],
                    [0.0, np.pi / 4, np.pi / 2]):
    matrix = b(t)
    optimal = truncation_error2(matrix, 1)
    fixed = float(np.linalg.norm(matrix - p0 @ matrix, ord="fro") ** 2)
    print(f"B t={label:4s} best={optimal:.3f} fixed={fixed:.3f}")
