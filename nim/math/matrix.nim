# matrix.nim: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices held as arrays of arrays.
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
#     nim c -r matrix.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

import std/[sequtils, strutils]

const
  Size = 3
  Left = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]
  Right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]

type Matrix = array[Size, array[Size, int]]

proc multiply(a, b: Matrix): Matrix =
  for i in 0 ..< Size:
    for j in 0 ..< Size:
      for k in 0 ..< Size:
        result[i][j] += a[i][k] * b[k][j]

proc determinant(m: Matrix): int =
  m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
    m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
    m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])

let product = multiply(Left, Right)

for row in product:
  echo row.mapIt($it).join(" ")
echo determinant(product)
