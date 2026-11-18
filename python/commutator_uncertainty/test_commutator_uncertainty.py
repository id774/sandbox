# test_commutator_uncertainty.py: Verify uncertainty residual examples
#
# Description:
#   Check direct matrix calculations, qubit equality, and qutrit bounds.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B -m unittest -v test_commutator_uncertainty
#
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only (unittest)

import unittest

from commutator_uncertainty import (
    RHO_1, RHO_2, SIGMA_X, SIGMA_Z, X_12, X_23, Y_12,
    coefficient, commutator, commutator_norm_squared, covariance, diagonal,
    expectation, purity, residual, variance,
)


class CommutatorUncertaintyTest(unittest.TestCase):
    def test_completely_mixed_qubit(self):
        rho = diagonal((0.5, 0.5))
        self.assertNotEqual(commutator(SIGMA_X, SIGMA_Z), ((0, 0), (0, 0)))
        self.assertAlmostEqual(abs(expectation(rho, commutator(SIGMA_X, SIGMA_Z))), 0)
        self.assertAlmostEqual(covariance(rho, SIGMA_X, SIGMA_Z), 0)
        self.assertAlmostEqual(variance(rho, SIGMA_X), 1)
        self.assertAlmostEqual(variance(rho, SIGMA_Z), 1)
        self.assertAlmostEqual(residual(rho, SIGMA_X, SIGMA_Z), 1)
        self.assertAlmostEqual(coefficient((0.5, 0.5)) *
                               commutator_norm_squared(rho, SIGMA_X, SIGMA_Z), 1)

    def test_qubit_mixed_identity(self):
        rho = diagonal((0.75, 0.25))
        actual = residual(rho, SIGMA_X, SIGMA_Z)
        lower = coefficient((0.75, 0.25)) * commutator_norm_squared(
            rho, SIGMA_X, SIGMA_Z
        )
        self.assertAlmostEqual(purity(rho), 0.625)
        self.assertAlmostEqual(actual, 0.75)
        self.assertAlmostEqual(lower, 0.75)
        self.assertAlmostEqual(actual, 2 * (1 - purity(rho)))

    def test_pure_qubit(self):
        rho = diagonal((1, 0))
        self.assertAlmostEqual(residual(rho, SIGMA_X, SIGMA_Z), 0)
        self.assertAlmostEqual(coefficient((0, 1)), 0)
        self.assertAlmostEqual(commutator_norm_squared(rho, SIGMA_X, SIGMA_Z), 4)

    def test_commuting_observables(self):
        rho = diagonal((0.75, 0.25))
        self.assertAlmostEqual(residual(rho, SIGMA_Z, SIGMA_Z), 0)
        self.assertAlmostEqual(commutator_norm_squared(rho, SIGMA_Z, SIGMA_Z), 0)

    def test_qutrit_equal_purity_different_coefficients(self):
        self.assertAlmostEqual(purity(RHO_1), 0.5)
        self.assertAlmostEqual(purity(RHO_2), 0.5)
        self.assertAlmostEqual(coefficient((1 / 6, 1 / 6, 2 / 3)), 1 / 12)
        self.assertAlmostEqual(coefficient((0, 0.5, 0.5)), 0)

    def test_qutrit_equality(self):
        actual = residual(RHO_1, X_12, Y_12)
        bound = coefficient((1 / 6, 1 / 6, 2 / 3)) * commutator_norm_squared(
            RHO_1, X_12, Y_12
        )
        self.assertAlmostEqual(actual, 1 / 9)
        self.assertAlmostEqual(commutator_norm_squared(RHO_1, X_12, Y_12), 4 / 3)
        self.assertAlmostEqual(bound, 1 / 9)

    def test_qutrit_strict_inequality(self):
        actual = residual(RHO_1, X_12, X_23)
        bound = coefficient((1 / 6, 1 / 6, 2 / 3)) * commutator_norm_squared(
            RHO_1, X_12, X_23
        )
        self.assertAlmostEqual(actual, 5 / 18)
        self.assertAlmostEqual(bound, 5 / 72)
        self.assertGreater(actual, bound)


if __name__ == '__main__':
    unittest.main()
