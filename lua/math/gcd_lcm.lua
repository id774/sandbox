-- gcd_lcm.lua: GCD and LCM of fixed pairs by Euclid's algorithm
--
-- Description:
-- Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a multiple assignment.
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
--     lua gcd_lcm.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

local pairs_to_report = { { 1071, 462 }, { 270, 192 }, { 17, 5 }, { 120, 36 } }

local function gcd(first, second)
  while second ~= 0 do
    first, second = second, first % second
  end
  return first
end

for _, pair in ipairs(pairs_to_report) do
  local first, second = pair[1], pair[2]
  local divisor = gcd(first, second)
  print(string.format("%d %d %d %d", first, second, divisor, first // divisor * second))
end
