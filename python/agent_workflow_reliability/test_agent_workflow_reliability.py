# test_agent_workflow_reliability.py: Test multi-stage workflow reliability
#
# Description:
# Exercise 16 unittest cases for probability calculations, input boundaries,
# recovery branches, reproducibility, and simulation error.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   python3 -B -m unittest discover -s python/agent_workflow_reliability -p 'test_*.py' -v
#
# Requirements:
# - Python 3 interpreter with dataclasses and math.prod
# - Python standard library only (including unittest)
#
# Verified Environment:
# Tested with Python 3.13.5.
#
import unittest

from agent_workflow_reliability import (
    Stage, required_stage, required_recovery, run_once,
    simulate, theoretical, tolerance,
)


class ReliabilityTest(unittest.TestCase):
    def test_v01_single_stage(self):
        self.assertAlmostEqual(theoretical([Stage(0.95)]), 0.95)

    def test_v02_uniform(self):
        self.assertAlmostEqual(theoretical([Stage(0.95)] * 20),
                               0.95 ** 20)

    def test_v03_heterogeneous(self):
        self.assertAlmostEqual(theoretical([Stage(0.8), Stage(0.9)]),
                               0.72)

    def test_v04_zero(self):
        self.assertEqual(theoretical([Stage(0)]), 0)
        self.assertEqual(simulate([Stage(0)], 100), 0)

    def test_v05_one(self):
        self.assertEqual(theoretical([Stage(1)] * 5), 1)
        self.assertEqual(simulate([Stage(1)] * 5, 100), 100)

    def test_v06_no_detection(self):
        self.assertEqual(Stage(0.95, 0, 1).effective(), 0.95)

    def test_v07_no_repair(self):
        self.assertEqual(Stage(0.95, 1, 0).effective(), 0.95)

    def test_v08_perfect_recovery(self):
        self.assertEqual(Stage(0, 1, 1).effective(), 1)
        self.assertEqual(simulate([Stage(0, 1, 1)], 100), 100)

    def test_v09_partial_recovery(self):
        self.assertAlmostEqual(Stage(0.95, 0.8, 0.9).effective(),
                               0.986)

    def test_v10_required_stage(self):
        self.assertAlmostEqual(required_stage(0.95, 20) ** 20, 0.95)

    def test_v11_required_recovery(self):
        dr = required_recovery(0.95, 0.95, 20)
        self.assertAlmostEqual(theoretical([Stage(0.95, 1, dr)] * 20),
                               0.95)
        self.assertEqual(required_recovery(1, 0.95, 20), 0)
        self.assertEqual(required_recovery(0.99, 0.95, 1), 0)

    def test_v12_invalid_probability(self):
        for args in ((-0.1,), (1.1,), (0.5, -1), (0.5, 1, 2),
                     (float('nan'),)):
            with self.subTest(args=args), self.assertRaises(ValueError):
                Stage(*args)
        with self.assertRaises(ValueError):
            required_stage(1.1, 20)

    def test_v13_invalid_counts(self):
        with self.assertRaises(ValueError):
            theoretical([])
        with self.assertRaises(ValueError):
            simulate([Stage(1)], 0)
        with self.assertRaises(ValueError):
            required_stage(0.95, -1)
        with self.assertRaises(ValueError):
            simulate([Stage(1)], 1.5)

    def test_v14_branches(self):
        stage = Stage(0.5, 0.8, 0.9)
        cases = (
            ([0.1, 0.1], True),
            ([0.6, 0.8], False),
            ([0.6, 0.1, 0.9], False),
            ([0.6, 0.1, 0.1, 0.1], True),
        )
        for values, expected in cases:
            with self.subTest(values=values):
                draws = iter(values)
                self.assertEqual(run_once([stage, stage],
                                          lambda: next(draws)), expected)
                self.assertEqual(list(draws), [])

    def test_v15_reproducibility(self):
        stages = [Stage(0.95, 0.8, 0.9)] * 5
        self.assertEqual(simulate(stages, 1000), simulate(stages, 1000))

    def test_v16_simulation(self):
        stages = [Stage(0.95, 0.8, 0.9)] * 20
        p = theoretical(stages)
        trials = 100_000
        observed = simulate(stages, trials) / trials
        self.assertLessEqual(abs(observed - p), tolerance(p, trials))


if __name__ == '__main__':
    unittest.main()
