# test_migration_judge_validation.py: Verify comparison judge decisions
#
# Description:
#   Exercise process observations, strict JSON parsing, numeric comparison,
#   and the expected decisions of all three judges with 16 tests.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B -m unittest -v test_migration_judge_validation.py
#
# Requirements:
#   - Python 3.10 or later
#   - Python standard library only
#
# Verified Environment:
#   Tested with Python 3.13.5 on Debian GNU/Linux 13 (x86_64).

import unittest

from migration_judge_validation import (
    COMPARATORS, Observation, cases, compare_contract, evaluate,
    metrics, run_fixture, strict_loads,
)


class JudgeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = list(cases())
        cls.by_id = {c.name: c for c in cls.data}

    def check_cases(self, *names):
        for name in names:
            with self.subTest(case=name):
                c = self.by_id[name]
                self.assertEqual(
                    compare_contract(c.old, c.new, c.mode), c.expected
                )

    def test_v01_normal_process(self):
        self.assertEqual(run_fixture(b'abc'), Observation(0, b'abc', b''))

    def test_v02_exit_status(self):
        self.assertEqual(self.by_id['N02'].new.returncode, 1)
        self.check_cases('N02')

    def test_v03_stderr(self):
        self.assertEqual(self.by_id['N03'].new.stderr, b'error')
        self.check_cases('N03', 'P06')

    def test_v04_timeout(self):
        result = self.by_id['N12'].new
        self.assertTrue(result.timed_out)
        self.assertIsNone(result.returncode)
        self.assertEqual(result.stdout, b'abc')
        self.check_cases('N12')

    def test_v05_raw_whitespace(self):
        self.check_cases('P01', 'N01')

    def test_v06_json_format(self):
        self.check_cases('P02', 'P03')

    def test_v07_missing_key(self):
        self.check_cases('N04')

    def test_v08_array_order(self):
        self.check_cases('N15')

    def test_v09_types(self):
        self.check_cases('N05', 'N06')
        old = Observation(0, b'{"x":[true]}', b'')
        new = Observation(0, b'{"x":[1]}', b'')
        self.assertFalse(compare_contract(old, new, 'json'))

    def test_v10_integer_precision(self):
        self.check_cases('N07')

    def test_v11_float_tolerance(self):
        self.check_cases('P04', 'P05', 'N08')
        old = Observation(0, b'0.0', b'')
        self.assertTrue(compare_contract(
            old, Observation(0, b'1e-12', b''), 'json'))
        self.assertFalse(compare_contract(
            old, Observation(0, b'1.01e-12', b''), 'json'))

    def test_v12_nonfinite(self):
        self.check_cases('N09', 'N10', 'N13')

        for payload in (b'NaN', b'Infinity', b'-Infinity', b'1e400'):
            with self.subTest(payload=payload):
                with self.assertRaises(ValueError):
                    strict_loads(payload)

        old = Observation(0, b'1.0', b'')
        self.assertFalse(compare_contract(
            old, Observation(0, b'-Infinity', b''), 'json'))

    def test_v13_duplicate_key(self):
        self.check_cases('N11')

    def test_v14_utf8(self):
        self.check_cases('N14')

        old = Observation(0, b'"a"', b'')

        for encoding in ('utf-16', 'utf-32'):
            with self.subTest(encoding=encoding):
                new = Observation(
                    0, '"a"'.encode(encoding), b''
                )
                self.assertFalse(
                    compare_contract(old, new, 'json')
                )

    def test_v15_metrics(self):
        alpha, beta, accuracy = metrics((2, 11, 4, 4))
        self.assertAlmostEqual(alpha, 4 / 15)
        self.assertAlmostEqual(beta, 4 / 6)
        self.assertAlmostEqual(accuracy, 13 / 21)

    def test_v16_all_decisions(self):
        expected_counts = {
            'A': (2, 11, 4, 4), 'B': (4, 8, 7, 2), 'C': (6, 15, 0, 0),
        }
        expected_accepts = {
            'A': {'P01', 'P06', 'N01', 'N02', 'N03', 'N12'},
            'B': {'P01', 'P02', 'P03', 'P06', 'N01', 'N02', 'N03',
                  'N05', 'N06', 'N11', 'N12'},
            'C': {'P01', 'P02', 'P03', 'P04', 'P05', 'P06'},
        }
        self.assertEqual(len(self.data), 21)
        self.assertEqual(len(self.by_id), 21)
        for key, comparator in COMPARATORS.items():
            with self.subTest(comparator=key):
                decisions, counts = evaluate(self.data, comparator)
                self.assertEqual(counts, expected_counts[key])
                self.assertEqual(
                    {name for name, passed in decisions.items() if passed},
                    expected_accepts[key],
                )


if __name__ == '__main__':
    unittest.main()
