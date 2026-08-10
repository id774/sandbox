#!/usr/bin/env ruby
# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.

ROWS = 10

row = [1]
ROWS.times do
  puts row.join(' ')
  row = ([0] + row).zip(row + [0]).map { |left, right| left + right }
end
