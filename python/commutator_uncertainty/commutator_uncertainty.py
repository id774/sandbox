# commutator_uncertainty.py: Check state-dependent uncertainty residual bounds
#
# Description:
#   Compare the Robertson-Schrodinger residual with the state-dependent
#   squared-commutator bound for fixed qubit and qutrit matrices.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/commutator_uncertainty/commutator_uncertainty.py
#
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only


def multiply(a, b):
    return tuple(
        tuple(sum(a[i][k] * b[k][j] for k in range(len(b)))
              for j in range(len(b[0])))
        for i in range(len(a))
    )


def subtract(a, b):
    return tuple(tuple(x - y for x, y in zip(row_a, row_b))
                 for row_a, row_b in zip(a, b))


def adjoint(a):
    return tuple(tuple(a[j][i].conjugate() for j in range(len(a)))
                 for i in range(len(a[0])))


def trace(a):
    return sum(a[i][i] for i in range(len(a)))


def expectation(rho, a):
    return trace(multiply(rho, a))


def variance(rho, a):
    mean = expectation(rho, a)
    return (expectation(rho, multiply(a, a)) - mean * mean).real


def covariance(rho, a, b):
    sym = (expectation(rho, multiply(a, b)) +
           expectation(rho, multiply(b, a))) / 2
    return (sym - expectation(rho, a) * expectation(rho, b)).real


def commutator(a, b):
    return subtract(multiply(a, b), multiply(b, a))


def residual(rho, a, b):
    comm_mean = expectation(rho, commutator(a, b))
    return (variance(rho, a) * variance(rho, b)
            - covariance(rho, a, b) ** 2 - abs(comm_mean) ** 2 / 4)


def commutator_norm_squared(rho, a, b):
    comm = commutator(a, b)
    return expectation(rho, multiply(adjoint(comm), comm)).real


def purity(rho):
    return trace(multiply(rho, rho)).real


def coefficient(eigenvalues):
    first, second = sorted(eigenvalues)[:2]
    if first == 0:
        return 0.0
    return first * second / (first + second)


def diagonal(values):
    return tuple(tuple(value if i == j else 0 for j in range(len(values)))
                 for i, value in enumerate(values))


SIGMA_X = ((0, 1), (1, 0))
SIGMA_Y = ((0, -1j), (1j, 0))
SIGMA_Z = ((1, 0), (0, -1))
X_12 = ((0, 1, 0), (1, 0, 0), (0, 0, 0))
Y_12 = ((0, -1j, 0), (1j, 0, 0), (0, 0, 0))
X_23 = ((0, 0, 0), (0, 0, 1), (0, 1, 0))
RHO_1 = diagonal((1 / 6, 1 / 6, 2 / 3))
RHO_2 = diagonal((0, 1 / 2, 1 / 2))


CASES = (
    ('qubit-mixed-max', diagonal((1 / 2, 1 / 2)),
     (1 / 2, 1 / 2), SIGMA_X, SIGMA_Z),
    ('qubit-mixed', diagonal((3 / 4, 1 / 4)),
     (1 / 4, 3 / 4), SIGMA_X, SIGMA_Z),
    ('qubit-pure', diagonal((1, 0)),
     (0, 1), SIGMA_X, SIGMA_Z),
    ('qutrit-equality', RHO_1, (1 / 6, 1 / 6, 2 / 3), X_12, Y_12),
    ('qutrit-strict', RHO_1, (1 / 6, 1 / 6, 2 / 3), X_12, X_23),
)


def main():
    print('case                purity    residual  lower_bound')
    for name, rho, eigenvalues, a, b in CASES:
        lower_bound = coefficient(eigenvalues) * commutator_norm_squared(
            rho, a, b
        )
        print(f'{name:19s} {purity(rho):9.6f} {residual(rho, a, b):11.6f}'
              f' {lower_bound:12.6f}')


if __name__ == '__main__':
    main()
