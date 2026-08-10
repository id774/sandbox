-- Print the first 20 Fibonacci numbers, collected into a table.
-- Run: lua fibonacci.lua

local function fibonacci(count)
  local values = {}
  local current, following = 0, 1
  for i = 1, count do
    values[i] = current
    current, following = following, current + following
  end
  return values
end

print(table.concat(fibonacci(20), " "))
