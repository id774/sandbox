-- Print FizzBuzz for 1 through 100, choosing the label from the remainders.
-- Run: lua fizzbuzz.lua

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
