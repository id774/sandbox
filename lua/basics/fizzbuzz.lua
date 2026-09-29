-- fizzbuzz.lua: FizzBuzz for 1 through 100
--
-- Description:
-- Print FizzBuzz for 1 through 100, choosing the label from the remainders.
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
--     lua fizzbuzz.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

local function label(n)
  if n % 15 == 0 then
    return "FizzBuzz"
  elseif n % 3 == 0 then
    return "Fizz"
  elseif n % 5 == 0 then
    return "Buzz"
  end
  return tostring(n)
end

for n = 1, 100 do
  print(label(n))
end
