# type_annotation_test.py: unittest tests for the annotated average function
#
# Description:
# Test the annotated average function with unittest, including error cases.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 type_annotation_test.py
#
# Requirements:
# - Python 3.5 or later, which provides the typing module
#

import unittest
from type_annotation import average

class TestAverageFunction(unittest.TestCase):
    def test_average(self):
        self.assertEqual(average([1, 2, 3, 4, 5]), 3.0)
        self.assertEqual(average([1, -1, 2, -2, 3]), 0.6)
        self.assertEqual(average([10, 20, 30]), 20.0)

    def test_average_empty_list(self):
        with self.assertRaises(ValueError):
            average([])

    def test_average_wrong_input_type(self):
        with self.assertRaises(TypeError):
            average("123")
        with self.assertRaises(TypeError):
            average(123)

if __name__ == "__main__":
    unittest.main()

