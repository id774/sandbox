-- Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
-- Run: lua pascal.lua

local rows = 10

local row = { 1 }
for length = 1, rows do
  print(table.concat(row, " "))

  row[length + 1] = 0
  for i = length + 1, 2, -1 do
    row[i] = row[i] + row[i - 1]
  end
end
