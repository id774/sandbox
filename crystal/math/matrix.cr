# matrix.cr: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.
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
#     crystal run matrix.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

LEFT = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]
RIGHT = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]

def multiply(left : Array(Array(Int32)), right : Array(Array(Int32))) : Array(Array(Int32))
  columns = right.transpose
  left.map { |row| columns.map { |column| row.zip(column).sum { |(x, y)| x * y } } }
end

def determinant(m : Array(Array(Int32))) : Int32
  m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
    m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
    m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
end

product = multiply(LEFT, RIGHT)

product.each { |row| puts row.join(" ") }
puts determinant(product)
