-- collatz.lua: Longest Collatz sequence for a start below 1000
--
-- Description:
-- Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
--     lua collatz.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

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
