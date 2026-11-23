# compensation.py: Verify synaptic compensation and convergence
#
# Description:
#   Simulate proportional weight updates with and without bounds, and
#   verify the unconstrained error recurrence against analytic values.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/synaptic_compensation/compensation.py
#
# Requirements:
#   - Python 3.6 or later (f-string support)
#   - Python standard library only (math)
#   - Run without -O so that assertions are evaluated.
#
# Verified Environment:
#   Tested with Python 3.13.5.

import math


def simulate(x, eta, target, initial_weight, steps, limits=None):
    weight = initial_weight
    history = []

    for t in range(steps + 1):
        output = x * weight
        error = target - output
        history.append((t, weight, output, error))

        if t == steps:
            break

        candidate = weight + eta * error
        if limits is not None:
            lower, upper = limits
            candidate = min(upper, max(lower, candidate))
        weight = candidate

    return history


def verify_unconstrained(x, eta, target, initial_weight, history):
    q = 1.0 - eta * x
    initial_error = target - x * initial_weight
    for t, _, output, error in history:
        expected_error = (q ** t) * initial_error
        assert math.isclose(
            error, expected_error, rel_tol=1e-12, abs_tol=1e-12
        ), (eta, t, error, expected_error)
        expected_output = target - expected_error
        assert math.isclose(
            output, expected_output, rel_tol=1e-12, abs_tol=1e-12
        ), (eta, t, output, expected_output)


x = 0.5
target = 1.0
initial_weight = 1.0
steps = 4

print("eta   q       e0        e1        e4")
for eta in (1.0, 2.0, 3.0, 4.0, 5.0):
    history = simulate(x, eta, target, initial_weight, steps)
    verify_unconstrained(x, eta, target, initial_weight, history)
    q = 1.0 - eta * x
    print(
        f"{eta:3.0f} {q:6.2f} "
        f"{history[0][3]:9.5f} "
        f"{history[1][3]:9.5f} "
        f"{history[4][3]:9.5f}"
    )

print("\nconstrained: eta=1, limits=[0, 1.5]")
constrained = simulate(
    x, 1.0, target, initial_weight, steps, limits=(0.0, 1.5)
)
for t, weight, output, error in constrained:
    print(f"t={t} w={weight:.5f} y={output:.5f} e={error:.5f}")

assert math.isclose(constrained[-1][1], 1.5, rel_tol=1e-12, abs_tol=1e-12)
assert math.isclose(constrained[-1][3], 0.25, rel_tol=1e-12, abs_tol=1e-12)
print("all checks passed")
