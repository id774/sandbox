-- matrix.lua: Product and determinant of two fixed 3x3 integer matrices
--
-- Description:
-- Multiply two fixed 3x3 integer matrices held as tables of tables.
--
-- Part of the math cross-language exercise set: it reads no arguments or
-- standard input, keeps its data fixed in the source, uses integer
-- arithmetic only, and its output is the same as that of the same exercise
-- in every other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lua matrix.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

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
