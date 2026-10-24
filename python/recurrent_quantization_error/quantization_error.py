# quantization_error.py: Recurrent-state quantization error experiment
#
# Description:
#   Compare injected error directions, error retention, and accumulated
#   state/output errors at different quantization intervals in a fixed
#   two-dimensional linear recurrence.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root with Python 3.13 and NumPy 2.3.4 installed:
#     python -B python/recurrent_quantization_error/quantization_error.py
#
# Requirements:
#   - Python 3.13
#   - NumPy 2.3.4
#   - Do not run with -O; the experiment includes assertion checks.

import numpy as np

A = np.diag(np.array([0.99, 0.5], dtype=np.float64))
G = np.array([1.0, 0.1], dtype=np.float64)
U = np.array([0.04, 0.09], dtype=np.float64)
STEPS = 128
DELTA = 0.125


def quantize(value):
    return DELTA * np.round(value / DELTA)


def compare_directions():
    e1 = np.array([0.02, 0.0], dtype=np.float64)
    e2 = np.array([0.0, 0.02], dtype=np.float64)
    assert np.isclose(np.mean(e1**2), np.mean(e2**2))
    print("direction: local_mse, output_error, output_squared_error")
    for name, error in (("axis1", e1), ("axis2", e2)):
        output_error = float(G @ error)
        print(f"  {name}: {np.mean(error**2):.6f}, {output_error:.6f}, {output_error**2:.6f}")


def compare_retention():
    print("retention: steps, factor(0.99), factor(0.5)")
    for t in (10, 50, 100):
        print(f"  {t}: {0.99**t:.9g}, {0.5**t:.9g}")


def simulate(interval):
    exact = np.zeros(2, dtype=np.float64)
    quantized = np.zeros(2, dtype=np.float64)
    previous_error = np.zeros(2, dtype=np.float64)
    local_mses = []

    for t in range(1, STEPS + 1):
        exact = A @ exact + U
        before_quantization = A @ quantized + U
        if t % interval == 0:
            quantized = quantize(before_quantization)
            local_mses.append(float(np.mean((quantized - before_quantization)**2)))
        else:
            quantized = before_quantization

        local_error = quantized - before_quantization
        state_error = quantized - exact
        assert np.allclose(state_error, A @ previous_error + local_error,
                           rtol=0, atol=1e-12)
        previous_error = state_error

    output_error = float(G @ state_error)
    return len(local_mses), float(np.mean(local_mses)), float(np.mean(state_error**2)), output_error, output_error**2


def compare_intervals():
    print("interval: operations, local_mse, final_state_mse, output_error, output_squared_error")
    for interval in (1, 8):
        operations, local_mse, state_mse, error, squared = simulate(interval)
        print(f"  {interval}: {operations}, {local_mse:.9f}, {state_mse:.9f}, {error:.9f}, {squared:.9f}")


if __name__ == "__main__":
    compare_directions()
    compare_retention()
    compare_intervals()
