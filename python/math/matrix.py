#!/usr/bin/env python3
# matrix.py: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, transposing the right one with zip to reach its columns.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 matrix.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

LEFT = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]
RIGHT = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]


def multiply(left, right):
    columns = list(zip(*right))
    return [[sum(x * y for x, y in zip(row, column)) for column in columns] for row in left]


def determinant(matrix):
    (a, b, c), (d, e, f), (g, h, i) = matrix
    return a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)


product = multiply(LEFT, RIGHT)

for row in product:
    print(" ".join(str(value) for value in row))
print(determinant(product))
