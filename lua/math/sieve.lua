-- Print the primes below 100, sieved over a table of flags indexed by the number itself.
-- Run: lua sieve.lua

local limit = 100

local is_prime = {}
for n = 2, limit - 1 do
  is_prime[n] = true
end

for n = 2, math.floor(math.sqrt(limit)) do
  if is_prime[n] then
    for multiple = n * n, limit - 1, n do
      is_prime[multiple] = false
    end
  end
end

local primes = {}
for n = 2, limit - 1 do
  if is_prime[n] then
    primes[#primes + 1] = n
  end
end

print(table.concat(primes, " "))
