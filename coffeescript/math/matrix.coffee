# matrix.coffee: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, with each entry folded by a comprehension over the shared index.
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
#     coffee matrix.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

left = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]
right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]

multiply = (a, b) ->
  for row in a
    for column in [0...b[0].length]
      sum = 0
      sum += value * b[index][column] for value, index in row
      sum

determinant = (m) ->
  [[a, b, c], [d, e, f], [g, h, i]] = m
  a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)

product = multiply(left, right)

for row in product
  console.log row.join ' '
console.log determinant(product)
