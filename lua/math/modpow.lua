-- Print modular powers of fixed triples, each squared and halved by repeated squaring.
-- Run: lua modpow.lua

local cases = { { 2, 1000, 1000003 }, { 3, 200, 50 }, { 5, 117, 19 }, { 10, 18, 9999991 } }

local function modpow(base, exponent, modulus)
  local result = 1
  base = base % modulus
  while exponent > 0 do
    if exponent % 2 == 1 then
      result = result * base % modulus
    end
    base = base * base % modulus
    exponent = exponent // 2
  end
  return result
end

for _, case in ipairs(cases) do
  local base, exponent, modulus = case[1], case[2], case[3]
  print(string.format("%d %d %d %d", base, exponent, modulus, modpow(base, exponent, modulus)))
end
