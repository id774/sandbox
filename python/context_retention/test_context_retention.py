# test_context_retention.py: Unit tests for history retention under capacity limits
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
import unittest

from context_retention import HISTORY, length, recent_first, required_first, rates


class RetentionTests(unittest.TestCase):
    def test_full_budget_keeps_all_records(self):
        for selector in (recent_first, required_first):
            self.assertEqual(selector(HISTORY, length(HISTORY)), HISTORY)

    def test_both_methods_respect_capacity(self):
        for percentage in (100, 70, 50, 25):
            capacity = length(HISTORY) * percentage // 100
            self.assertLessEqual(length(recent_first(HISTORY, capacity)), capacity)
            try:
                selected = required_first(HISTORY, capacity)
            except ValueError:
                self.assertLess(capacity, length([r for r in HISTORY if r.required]))
                continue
            self.assertLessEqual(length(selected), capacity)

    def test_required_records_are_preserved_when_feasible(self):
        required = [record for record in HISTORY if record.required]
        capacity = length(required)
        self.assertEqual(required_first(HISTORY, capacity), required)

    def test_insufficient_capacity_is_reported(self):
        required = [record for record in HISTORY if record.required]
        with self.assertRaisesRegex(ValueError, "required records exceed capacity"):
            required_first(HISTORY, length(required) - 1)

    def test_selection_keeps_original_order_and_text(self):
        for selector in (recent_first, required_first):
            records = selector(HISTORY, length(HISTORY) * 70 // 100)
            ids = [record.id for record in records]
            self.assertEqual(ids, sorted(ids))
            self.assertEqual(rates(HISTORY, records)[2], 1.0)

    def test_protected_selection_improves_required_retention(self):
        capacity = length(HISTORY) * 50 // 100
        recent = recent_first(HISTORY, capacity)
        protected = required_first(HISTORY, capacity)
        self.assertGreater(rates(HISTORY, protected)[1], rates(HISTORY, recent)[1])


if __name__ == "__main__":
    unittest.main()
