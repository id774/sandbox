-- sieve.lua: Primes below 100 by the sieve of Eratosthenes
--
-- Description:
-- Print the primes below 100, sieved over a table of flags indexed by the number itself.
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
--     lua sieve.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

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
