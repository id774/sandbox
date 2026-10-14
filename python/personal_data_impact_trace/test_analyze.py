# test_analyze.py: Tests for personal-data transfer tracing
#
# Description:
# Check upstream traversal, excluded datasets, cycles, and invalid records.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     cd python/personal_data_impact_trace
#     python3 -m unittest -v
#
# Requirements:
# - Python 3.12 or later
# - Only the Python standard library is required

import csv
import tempfile
import unittest
from pathlib import Path

from analyze import analyze


class AnalyzeTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.directory = Path(temporary.name)
        self.inventory = [
            ["store", "retailer", "shipping_01", "customers", "shipping_address"],
            ["ship", "carrier", "shipping_01", "customers", "shipping_address"],
            ["subship", "subcontractor", "shipping_01", "customers", "shipping_address"],
            ["store", "retailer", "login_01", "customers", "password_hash"],
        ]
        self.transfers = [
            ["shipping_01", "store", "ship"],
            ["shipping_01", "ship", "subship"],
        ]

    def write_inputs(self):
        for name, header, rows in [
            ("inventory.csv", ["system", "operator", "dataset", "subjects", "data_type"], self.inventory),
            ("transfers.csv", ["dataset", "src", "dst"], self.transfers),
        ]:
            with (self.directory / name).open("w", encoding="utf-8", newline="") as file:
                writer = csv.writer(file)
                writer.writerow(header)
                writer.writerows(rows)

    def test_subcontractor_traces_both_transfers(self):
        self.write_inputs()
        result = analyze(self.directory, "subship")
        self.assertEqual([row["dataset"] for row in result], ["shipping_01"])
        self.assertEqual(result[0]["related_systems"], ["ship", "store", "subship"])
        self.assertEqual(result[0]["related_operators"], ["carrier", "retailer", "subcontractor"])
        self.assertEqual(result[0]["transfers"], [
            {"src": "ship", "dst": "subship"},
            {"src": "store", "dst": "ship"},
        ])

    def test_store_does_not_imply_downstream_compromise(self):
        self.write_inputs()
        result = analyze(self.directory, "store")
        self.assertEqual([row["dataset"] for row in result], ["login_01", "shipping_01"])
        self.assertTrue(all(row["related_systems"] == ["store"] for row in result))
        self.assertTrue(all(row["transfers"] == [] for row in result))

    def test_cycle_terminates(self):
        self.transfers.append(["shipping_01", "subship", "ship"])
        self.write_inputs()
        result = analyze(self.directory, "subship")
        self.assertEqual(len(result[0]["transfers"]), 3)

    def test_missing_transfer_endpoint_is_error(self):
        self.transfers.append(["shipping_01", "ghost", "ship"])
        self.write_inputs()
        with self.assertRaisesRegex(ValueError, "transfer endpoint missing"):
            analyze(self.directory, "subship")

    def test_unknown_system_is_error(self):
        self.write_inputs()
        with self.assertRaisesRegex(ValueError, "unknown system"):
            analyze(self.directory, "unknown")

    def test_duplicate_inventory_entry_is_error(self):
        self.inventory.append(self.inventory[0][:])
        self.write_inputs()
        with self.assertRaisesRegex(ValueError, "duplicate inventory"):
            analyze(self.directory, "subship")

    def test_invalid_row_is_error(self):
        self.inventory[0][3] = ""
        self.write_inputs()
        with self.assertRaisesRegex(ValueError, "invalid row"):
            analyze(self.directory, "subship")


if __name__ == "__main__":
    unittest.main()
