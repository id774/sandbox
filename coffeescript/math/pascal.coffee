# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
# Run: coffee pascal.coffee

rows = 10

row = [1]
for i in [0...rows]
  console.log row.join ' '
  shifted = [0].concat row
  padded = row.concat [0]
  row = (value + padded[index] for value, index in shifted)
