# Multiply two fixed 3x3 integer matrices held as arrays of arrays.
# Run: nim c -r matrix.nim

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
