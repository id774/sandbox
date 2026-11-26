# test_leakage_audit.py: Test joint-observation information leakage
#
# Description:
# Check normalization, prior entropy, four fixed cases, the chain rule,
# information bounds, and invalid probability distributions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Test:
# cd python/joint_observation_leakage
# python3 -B -m unittest -v
#
# Requirements:
# - Python 3.9 or later (dictionary union in the invalid-input test)
# - Python standard library only
#
# Verified Environment:
# Tested with Python 3.13.5.

import unittest
from math import fsum

from leakage_audit import (
    TOL, WEIGHTS, entropy, evaluate, make_distribution, marginalize,
    validate_distribution,
)


class LeakageAuditTest(unittest.TestCase):
    def assert_close(self, actual, expected):
        self.assertAlmostEqual(actual, expected, delta=TOL)

    def check_case(self, case, expected):
        for actual, target in zip(evaluate(make_distribution(case)), expected):
            self.assert_close(actual, target)

    def test_v01_normalization(self):
        for case in WEIGHTS:
            with self.subTest(case=case):
                self.assert_close(fsum(make_distribution(case).values()), 1)

    def test_v02_prior_entropy(self):
        for case in WEIGHTS:
            with self.subTest(case=case):
                d = make_distribution(case)
                self.assertEqual(marginalize(d, (0,)), {(0,): 0.5, (1,): 0.5})
                self.assert_close(entropy(d, (0,)), 1)

    def test_v03_independent(self):
        self.check_case("C01", (0, 0, 0, 0))

    def test_v04_single(self):
        self.check_case("C02", (1, 0, 1, 0))

    def test_v05_joint_only(self):
        self.check_case("C03", (0, 0, 1, 1))

    def test_v06_redundant(self):
        self.check_case("C04", (1, 1, 1, 0))

    def test_v07_chain_rule(self):
        for case in WEIGHTS:
            with self.subTest(case=case):
                first, _, joint, additional = evaluate(make_distribution(case))
                self.assert_close(joint, first + additional)

    def test_v08_bounds(self):
        for case in WEIGHTS:
            with self.subTest(case=case):
                d = make_distribution(case)
                for value in evaluate(d):
                    self.assertGreaterEqual(value, -TOL)
                    self.assertLessEqual(value, entropy(d, (0,)) + TOL)

    def test_v09_invalid_distribution(self):
        valid = make_distribution("C01")
        state = (0, 0, 0)
        missing = dict(valid)
        del missing[state]
        wrong = dict(valid)
        wrong[(2, 0, 0)] = wrong.pop(state)
        cases = [missing, wrong]
        for p in (-0.125, float("nan"), float("inf"), 1.125, 0.25):
            cases.append(valid | {state: p})
        for i, invalid in enumerate(cases):
            with self.subTest(case=i):
                with self.assertRaises(ValueError):
                    validate_distribution(invalid)


if __name__ == "__main__":
    unittest.main()
