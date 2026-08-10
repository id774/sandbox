# Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
# Run: crystal run pascal.cr

ROWS = 10

row = [1]
ROWS.times do
  puts row.join(" ")
  row = ([0] + row).zip(row + [0]).map { |(left, right)| left + right }
end
