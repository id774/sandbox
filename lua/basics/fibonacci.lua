-- fibonacci.lua: The first 20 Fibonacci numbers
--
-- Description:
-- Print the first 20 Fibonacci numbers, collected into a table.
--
-- Part of the basics cross-language exercise set: the input is fixed in the
-- source, and the output is the same as that of the same exercise in every
-- other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lua fibonacci.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

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
