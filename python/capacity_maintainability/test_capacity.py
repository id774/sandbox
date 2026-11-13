# test_capacity.py: Check capacity margins, boundaries, and quantified maintainability
#
# Description:
#   Check capacity margins, boundaries, and quantified maintainability.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B -m unittest -v test_capacity
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only (unittest, functools, itertools)

import unittest
from functools import lru_cache
from itertools import product

from capacity import (
    can_maintain,
    margin,
    max_horizon,
    required_margin,
    simulate,
    transition,
)


@lru_cache(maxsize=None)
def feasible(m: int, U: int, W: int, H: int) -> bool:
    if m < 0:
        return False
    if H == 0:
        return True
    return any(
        all(feasible(m + u - w, U, W, H - 1) for w in range(W + 1))
        for u in range(U + 1)
    )


class CapacityTests(unittest.TestCase):
    def test_transition(self):
        self.assertEqual(margin(120, 100), 20)
        self.assertEqual(transition(120, 100, 20, 30), (140, 130))
        rows = simulate(120, 100, [20] * 5, [30] * 5)
        self.assertEqual(
            [row[3] for row in rows], [20, 10, 0, -10, -20, -30]
        )
        self.assertEqual(
            [row[4] for row in rows], [True, True, True, False, False, False]
        )

    def test_horizon(self):
        cases = [
            (0, 20, 30, 0),
            (10, 20, 30, 1),
            (20, 20, 30, 2),
            (30, 20, 30, 3),
            (0, 30, 30, None),
            (0, 40, 30, None),
            (0, 0, 0, None),
        ]
        for m0, U, W, expected in cases:
            with self.subTest(m0=m0, U=U, W=W):
                self.assertEqual(max_horizon(m0, U, W), expected)
                if expected is None:
                    self.assertTrue(can_maintain(m0, U, W, 100))
                    rows = simulate(100 + m0, 100, [U] * 100, [W] * 100)
                    self.assertTrue(all(row[4] for row in rows))
                else:
                    self.assertTrue(can_maintain(m0, U, W, expected))
                    self.assertFalse(can_maintain(m0, U, W, expected + 1))
                    rows = simulate(
                        100 + m0, 100,
                        [U] * (expected + 1), [W] * (expected + 1)
                    )
                    self.assertTrue(all(row[4] for row in rows[:-1]))
                    self.assertFalse(rows[-1][4])

    def test_required_margin_boundary(self):
        self.assertEqual(required_margin(20, 30, 5), 50)
        for m0, expected in [(49, False), (50, True), (51, True)]:
            with self.subTest(m0=m0):
                self.assertEqual(can_maintain(m0, 20, 30, 5), expected)
                rows = simulate(100 + m0, 100, [20] * 5, [30] * 5)
                self.assertEqual(rows[-1][3], m0 - 50)
                self.assertEqual(all(row[4] for row in rows), expected)

    def test_all_disturbance_sequences(self):
        U, W, H = 2, 3, 3
        for m0, expected in [(2, False), (3, True), (4, True)]:
            with self.subTest(m0=m0):
                outcomes = []
                for ws in product(range(W + 1), repeat=H):
                    rows = simulate(100 + m0, 100, [U] * H, list(ws))
                    outcomes.append(all(row[4] for row in rows))
                self.assertEqual(len(outcomes), 64)
                self.assertEqual(all(outcomes), expected)
                self.assertEqual(can_maintain(m0, U, W, H), expected)

    def test_quantified_recurrence(self):
        cases = product(range(-1, 11), range(4), range(4), range(4))
        for m0, U, W, H in cases:
            with self.subTest(m0=m0, U=U, W=W, H=H):
                self.assertEqual(
                    can_maintain(m0, U, W, H), feasible(m0, U, W, H)
                )

    def test_zero_horizon_and_negative_margin(self):
        self.assertEqual(required_margin(20, 30, 0), 0)
        self.assertTrue(can_maintain(0, 20, 30, 0))
        self.assertFalse(can_maintain(-1, 20, 30, 0))
        self.assertFalse(can_maintain(-1, 40, 30, 5))
        self.assertEqual(
            simulate(99, 100, [], []), [(0, 99, 100, -1, False)]
        )
        self.assertEqual(
            simulate(100, 100, [], []), [(0, 100, 100, 0, True)]
        )
        with self.assertRaises(ValueError):
            max_horizon(-1, 20, 30)

    def test_invalid_input(self):
        for args in [(-1, 30, 5), (20, -1, 5), (20, 30, -1)]:
            with self.subTest(args=args), self.assertRaises(ValueError):
                required_margin(*args)
        for args in [(-1, 100), (100, -1)]:
            with self.subTest(args=args), self.assertRaises(ValueError):
                margin(*args)
        for args in [(100, 100, -1, 0), (100, 100, 0, -1)]:
            with self.subTest(args=args), self.assertRaises(ValueError):
                transition(*args)
        with self.assertRaises(ValueError):
            can_maintain(-1, -1, 30, 5)
        for args in [(0, -1, 30), (0, 20, -1)]:
            with self.subTest(args=args), self.assertRaises(ValueError):
                max_horizon(*args)
        with self.assertRaises(ValueError):
            simulate(100, 100, [20], [])
        with self.assertRaises(TypeError):
            required_margin(20, 30, 1.5)


if __name__ == "__main__":
    unittest.main()
