-- Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a multiple assignment.
-- Run: lua gcd_lcm.lua

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
