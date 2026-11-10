# boolean_influence.py: Verify variance and maximum bit-flip influence
#
# Description:
# Enumerate Boolean inputs for bit means, normalized sums, and majority,
# then compare variance, maximum influence, and majority degree conditions
# with exact formulas using the Python standard library.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/boolean_function_influence/boolean_influence.py
#
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only (itertools and math)

from itertools import product
from math import comb, isclose, sqrt

SIZES = (3, 5, 7, 9, 11)
TOLERANCE = 1e-12


def bit_mean(bits):
    return sum(bits) / len(bits)


def normalized_sum(bits):
    return sum(2 * bit - 1 for bit in bits) / sqrt(len(bits))


def majority(bits):
    return int(2 * sum(bits) > len(bits))


def evaluate(function, n):
    # product() visits bit strings in the same order as their binary indices.
    values = [function(bits) for bits in product((0, 1), repeat=n)]
    count = len(values)
    mean = sum(values) / count
    variance = sum((value - mean) ** 2 for value in values) / count
    influences = []
    for i in range(n):
        mask = 1 << (n - 1 - i)
        influences.append(
            sum((value - values[index ^ mask]) ** 2
                for index, value in enumerate(values)) / count
        )
    return values, variance, max(influences)


def majority_top_coefficient(n):
    return sum(
        (-1) ** (n - sum(bits)) * majority(bits)
        for bits in product((0, 1), repeat=n)
    )


def check_close(actual, expected):
    if not isclose(actual, expected, rel_tol=TOLERANCE, abs_tol=TOLERANCE):
        raise AssertionError((actual, expected))


def main():
    cases = (
        ("mean", bit_mean),
        ("sum", normalized_sum),
        ("majority", majority),
    )
    print("N  function     V(calc)    V(theory)   Imax(calc)  Imax(theory)")
    for n in SIZES:
        for name, function in cases:
            values, variance, max_influence = evaluate(function, n)
            if name == "mean":
                expected_v, expected_i = 1 / (4 * n), 1 / n**2
                check_close(min(values), 0)
                check_close(max(values), 1)
            elif name == "sum":
                expected_v, expected_i = 1.0, 4 / n
                check_close(min(values), -sqrt(n))
                check_close(max(values), sqrt(n))
            else:
                expected_v = 0.25
                expected_i = comb(n - 1, (n - 1) // 2) / 2 ** (n - 1)
                check_close(min(values), 0)
                check_close(max(values), 1)
                expected_coefficient = (-1) ** ((n - 1) // 2) * comb(
                    n - 1, (n - 1) // 2
                )
                actual_coefficient = majority_top_coefficient(n)
                if actual_coefficient != expected_coefficient:
                    raise AssertionError((actual_coefficient, expected_coefficient))
            check_close(variance, expected_v)
            check_close(max_influence, expected_i)
            print(
                f"{n:2d} {name:9s} {variance:10.6f} {expected_v:12.6f}"
                f" {max_influence:12.6f} {expected_i:13.6f}"
            )
    print("All checks passed.")


if __name__ == "__main__":
    main()
