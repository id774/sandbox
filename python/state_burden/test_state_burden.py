# test_state_burden.py: Check state updates and independent acceptance conditions
#
# Description:
#   Check analytical solutions, saturation, and independent acceptance
#   conditions for the four state-update scenarios.
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B -m unittest -v test_state_burden
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only (math, unittest)

import math
import unittest

from state_burden import CASES, STEPS, evaluate, simulate


class StateBurdenTest(unittest.TestCase):
    def assert_close(self, actual, expected):
        self.assertTrue(
            math.isclose(actual, expected, rel_tol=1e-12, abs_tol=1e-12),
            msg=f'{actual!r} != {expected!r}',
        )

    def test_initial_state(self):
        for case in CASES:
            with self.subTest(case=case.name):
                initial = simulate(case, 0)[0]
                self.assertEqual(initial.t, 0)
                self.assertEqual(initial.q, 0.5)
                self.assertIsNone(initial.amplitude)
                self.assert_close(initial.burden, case.p + 0.5)
                with self.assertRaises(ValueError):
                    evaluate(initial)

    def test_step_count(self):
        for case in CASES:
            with self.subTest(case=case.name):
                samples = simulate(case, STEPS)
                self.assertEqual(len(samples), 101)
                self.assertEqual([s.t for s in samples], list(range(101)))

    def test_decay(self):
        samples = simulate(CASES[0], STEPS)
        for s in samples:
            expected = 0.5 * 0.9 ** s.t
            self.assert_close(s.q, expected)
            self.assert_close(s.burden, expected)
            if s.t > 0:
                self.assert_close(s.amplitude, 0.05 * 0.9 ** (s.t - 1))

    def test_fixed(self):
        samples = simulate(CASES[1], STEPS)
        for s in samples[1:]:
            self.assertEqual(s.q, 0.5)
            self.assertEqual(s.amplitude, 0.0)
            self.assertEqual(s.burden, 0.5)

    def test_forced(self):
        samples = simulate(CASES[2], STEPS)
        for s in samples:
            expected = 0.4 + 0.1 * 0.9 ** s.t
            self.assert_close(s.q, expected)
            self.assert_close(s.burden, expected + 0.2)
            if s.t > 0:
                self.assert_close(s.amplitude, 0.01 * 0.9 ** (s.t - 1))

    def test_saturation(self):
        samples = simulate(CASES[3], STEPS)
        for s in samples:
            expected = min(1.0, 0.5 * 1.1 ** s.t)
            self.assert_close(s.q, expected)
            self.assert_close(s.burden, expected)
            if s.t > 0:
                previous = min(1.0, 0.5 * 1.1 ** (s.t - 1))
                self.assert_close(s.amplitude, abs(expected - previous))
        self.assertLess(samples[7].q, 1.0)
        self.assertEqual(samples[8].q, 1.0)
        self.assertGreater(samples[8].amplitude, 0.0)
        self.assertEqual(samples[9].amplitude, 0.0)

    def test_independent_conditions(self):
        expected = (
            (True, True, True),
            (True, False, False),
            (True, False, False),
            (True, False, False),
        )
        for case, result in zip(CASES, expected):
            with self.subTest(case=case.name):
                self.assertEqual(evaluate(simulate(case, STEPS)[-1]), result)


if __name__ == '__main__':
    unittest.main()
