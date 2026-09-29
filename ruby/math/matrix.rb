#!/usr/bin/env ruby
# matrix.rb: Product and determinant of two fixed 3x3 integer matrices
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
#     ruby matrix.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

LEFT = [[2, -1, 0], [1, 3, 4], [0, 5, -2]].freeze
RIGHT = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]].freeze

def multiply(left, right)
  columns = right.transpose
  left.map { |row| columns.map { |column| row.zip(column).sum { |x, y| x * y } } }
end

def determinant(matrix)
  (a, b, c), (d, e, f), (g, h, i) = matrix
  a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)
end

product = multiply(LEFT, RIGHT)

product.each { |row| puts row.join(' ') }
puts determinant(product)
