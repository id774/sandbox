-- Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
-- Run: lua collatz.lua

local limit = 1000

local function chain_length(start)
  local value = start
  local length = 1
  while value ~= 1 do
    if value % 2 == 0 then
      value = value // 2
    else
      value = value * 3 + 1
    end
    length = length + 1
  end
  return length
end

local longest, best = 1, 1
for start = 1, limit - 1 do
  local length = chain_length(start)
  if length > best then
    longest, best = start, length
  end
end

print(string.format("%d %d", longest, best))
