# test_delivery_handoff.py: Test a fixed JSON delivery handoff contract
#
# Description:
#   Exercise 11 valid, boundary, and invalid delivery-handoff cases using
#   a fixed fictional order and return request date.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B -m unittest discover -s python/agent_handoff_validation -p 'test_*.py' -v
#
# Requirements:
#   - Python 3.11 or later
#   - Python standard library only
#   - No command-line arguments, network requests, or external data files
#
import json
import unittest
from datetime import date

from delivery_handoff import within_return_window


ORDER_ID = "ORD-001"
REQUESTED_AT = date(2026, 10, 25)
DELIVERY = {
    "order_id": ORDER_ID,
    "delivery_status": "delivered",
    "delivered_at": "2026-10-10",
}


class DeliveryHandoffTests(unittest.TestCase):
    def check(self, delivery: dict) -> bool:
        return within_return_window(
            json.dumps(delivery), ORDER_ID, REQUESTED_AT
        )

    def test_t01_fifteen_days(self):
        self.assertTrue(self.check(DELIVERY))

    def test_t02_same_day(self):
        self.assertTrue(self.check({**DELIVERY, "delivered_at": "2026-10-25"}))

    def test_t03_thirty_days(self):
        self.assertTrue(self.check({**DELIVERY, "delivered_at": "2026-09-25"}))

    def test_t04_thirty_one_days(self):
        self.assertFalse(self.check({**DELIVERY, "delivered_at": "2026-09-24"}))

    def test_t05_missing_date(self):
        without_date = {key: value for key, value in DELIVERY.items()
                        if key != "delivered_at"}
        with self.assertRaises(ValueError):
            self.check(without_date)

    def test_t06_null_date(self):
        with self.assertRaises(ValueError):
            self.check({**DELIVERY, "delivered_at": None})

    def test_t07_invalid_date(self):
        with self.assertRaises(ValueError):
            self.check({**DELIVERY, "delivered_at": "2026-02-30"})

    def test_t08_wrong_order_id(self):
        with self.assertRaises(ValueError):
            self.check({**DELIVERY, "order_id": "ORD-002"})

    def test_t09_incomplete_delivery(self):
        with self.assertRaises(ValueError):
            self.check({**DELIVERY, "delivery_status": "in_transit"})

    def test_t10_invalid_json(self):
        with self.assertRaises(ValueError):
            within_return_window("{broken", ORDER_ID, REQUESTED_AT)

    def test_t11_future_delivery_date(self):
        with self.assertRaises(ValueError):
            self.check({**DELIVERY, "delivered_at": "2026-10-26"})


if __name__ == "__main__":
    unittest.main()
