#!/usr/bin/env python3
# Multiply two fixed 3x3 integer matrices, transposing the right one with zip to reach its columns.

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
