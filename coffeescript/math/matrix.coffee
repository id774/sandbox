# Multiply two fixed 3x3 integer matrices, with each entry folded by a comprehension over the shared index.
# Run: coffee matrix.coffee

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
