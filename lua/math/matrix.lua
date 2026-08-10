-- Multiply two fixed 3x3 integer matrices held as tables of tables.
-- Run: lua matrix.lua

local size = 3
local left = { { 2, -1, 0 }, { 1, 3, 4 }, { 0, 5, -2 } }
local right = { { 1, 0, 2 }, { -3, 1, 1 }, { 4, 2, 0 } }

local function multiply(a, b)
  local product = {}
  for i = 1, size do
    product[i] = {}
    for j = 1, size do
      local sum = 0
      for k = 1, size do
        sum = sum + a[i][k] * b[k][j]
      end
      product[i][j] = sum
    end
  end
  return product
end

local function determinant(m)
  return m[1][1] * (m[2][2] * m[3][3] - m[2][3] * m[3][2])
       - m[1][2] * (m[2][1] * m[3][3] - m[2][3] * m[3][1])
       + m[1][3] * (m[2][1] * m[3][2] - m[2][2] * m[3][1])
end

local product = multiply(left, right)

for i = 1, size do
  print(table.concat(product[i], " "))
end
print(determinant(product))
