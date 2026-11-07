# grad_diff_linear.py: Compare GradDiff forgetting loss with retrained-model output differences
#
# Description:
#   Solve a fixed L2-regularized linear regression experiment for six GradDiff
#   coefficients and compare the forgetting loss and prediction RMS differences
#   on forgotten and retained examples against retraining.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root with Python 3.12 and NumPy 2.2.6 installed:
#     python -B python/grad_diff_linear/grad_diff_linear.py
#
# Requirements:
#   - Python 3.12
#   - NumPy 2.2.6
#   - Assertions enabled; do not run with -O or PYTHONOPTIMIZE.

import numpy as np

X_r = np.array([[1., 0.], [0., 1.], [1., 1.], [2., 1.]])
y_r = np.array([1., 2., 3., 4.])
X_f = np.array([[1., 0.]])
y_f = np.array([5.])

n = len(X_r) + len(X_f)
lam = 0.1
ident = np.eye(X_r.shape[1])

X_all = np.vstack((X_r, X_f))
y_all = np.concatenate((y_r, y_f))
H_all = X_all.T @ X_all / n + lam * ident
b_all = X_all.T @ y_all / n
theta_all = np.linalg.solve(H_all, b_all)

H_r = X_r.T @ X_r / n + lam * ident
b_r = X_r.T @ y_r / n
theta_r = np.linalg.solve(H_r, b_r)

K_ff = X_f @ np.linalg.solve(H_r, X_f.T)
K_rf = X_r @ np.linalg.solve(H_r, X_f.T)
e_f = X_f @ theta_r - y_f
rho_crit = n / np.linalg.eigvalsh(K_ff)[-1]

print(f"theta_all: {theta_all}")
print(f"theta_retrained: {theta_r}")
print(f"rho_crit: {rho_crit:.6f}")
print("rho   forget_loss   RMS_f       RMS_r       min_eig")
for rho in (0.0, 0.1, 0.5, 1.0, 3.5, 3.9):
    M = H_r - rho * (X_f.T @ X_f) / n
    min_eig = np.linalg.eigvalsh(M)[0]
    assert min_eig > 0.0
    b = b_r - rho * (X_f.T @ y_f) / n
    theta = np.linalg.solve(M, b)

    delta_f = X_f @ (theta - theta_r)
    delta_r = X_r @ (theta - theta_r)
    forget_loss = 0.5 * np.mean((X_f @ theta - y_f) ** 2)
    rms_f = np.sqrt(np.mean(delta_f ** 2))
    rms_r = np.sqrt(np.mean(delta_r ** 2))

    gain = np.linalg.solve(np.eye(len(X_f)) - rho * K_ff / n, e_f)
    expected_f = rho * (K_ff @ gain) / n
    expected_r = rho * (K_rf @ gain) / n
    assert np.allclose(delta_f, expected_f)
    assert np.allclose(delta_r, expected_r)

    print(f"{rho:3.1f}   {forget_loss:11.6f}   {rms_f:9.6f}   "
          f"{rms_r:9.6f}   {min_eig:9.6f}")
