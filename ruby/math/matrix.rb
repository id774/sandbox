#!/usr/bin/env ruby
# Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.

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
