# test_structure.py: Check directed graph change measurement
#
# Description:
#   Verify binary encoding, four fixed updates, signed changes, changed-edge
#   identities, invalid-edge rejection, and the squared-distance identity.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B -m unittest -v
#
# Requirements:
#   - Python 3.8 or later
#   - Python standard library only (unittest, math)

import math
import unittest

from structure import EDGE_ORDER, STATES, encode, measure


class TestStructure(unittest.TestCase):
    def test_initial_vector(self):
        self.assertEqual(encode(STATES[0]), (1, 1, 1, 0, 0, 0))

    def test_order_is_fixed(self):
        self.assertEqual(
            encode(reversed(tuple(STATES[1]))),
            (1, 1, 1, 1, 1, 0),
        )

    def test_unknown_edge_is_rejected(self):
        with self.assertRaises(ValueError):
            encode({("D", "A")})

    def test_directed_edge_is_distinct(self):
        with self.assertRaises(ValueError):
            encode({("B", "A")})  # A -> B is a different edge.

    def test_unchanged_structure(self):
        item = measure(STATES[0], STATES[0])
        self.assertEqual(item["amplitude"], 0)
        self.assertEqual(item["delta_edges"], 0)
        self.assertFalse(item["added"] | item["removed"])

    def test_four_updates(self):
        expected = (
            ((1, 1, 1, 1, 1, 0), math.sqrt(2), +2, 5),
            ((1, 1, 1, 1, 0, 0), 1, -1, 4),
            ((1, 1, 1, 0, 0, 0), 1, -1, 3),
            ((1, 1, 1, 0, 0, 1), 1, +1, 4),
        )
        for t, (vector, amplitude, delta, count) in enumerate(expected, 1):
            with self.subTest(t=t):
                item = measure(STATES[t - 1], STATES[t])
                self.assertEqual(item["vector"], vector)
                self.assertAlmostEqual(item["amplitude"], amplitude)
                self.assertEqual(item["delta_edges"], delta)
                self.assertEqual(item["edge_count"], count)

    def test_same_amplitude_opposite_direction(self):
        deletion = measure(STATES[1], STATES[2])
        addition = measure(STATES[3], STATES[4])
        self.assertEqual(deletion["amplitude"], addition["amplitude"])
        self.assertEqual((deletion["delta_edges"], addition["delta_edges"]), (-1, 1))

    def test_same_metrics_different_removed_edges(self):
        first = measure(STATES[1], STATES[2])
        second = measure(STATES[2], STATES[3])
        self.assertEqual((first["amplitude"], first["delta_edges"]),
                         (second["amplitude"], second["delta_edges"]))
        self.assertEqual(first["removed"], {EDGE_ORDER[4]})
        self.assertEqual(second["removed"], {EDGE_ORDER[3]})

    def test_count_identity(self):
        for before, after in zip(STATES, STATES[1:]):
            with self.subTest(before=encode(before), after=encode(after)):
                item = measure(before, after)
                added = len(item["added"])
                removed = len(item["removed"])
                self.assertAlmostEqual(item["amplitude"] ** 2, added + removed)
                self.assertEqual(item["delta_edges"], added - removed)

    def test_return_to_initial_structure(self):
        self.assertEqual(STATES[0], STATES[3])
        self.assertEqual(measure(STATES[0], STATES[3])["amplitude"], 0)
        self.assertGreater(
            sum(measure(STATES[t - 1], STATES[t])["amplitude"] for t in range(1, 4)),
            0,
        )


if __name__ == "__main__":
    unittest.main()
