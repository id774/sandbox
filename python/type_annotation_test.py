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

