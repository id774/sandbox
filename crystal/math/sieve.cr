# sieve.cr: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags indexed by the number itself.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     crystal run sieve.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

LIMIT = 100

is_prime = Array.new(LIMIT, true)
is_prime[0] = false
is_prime[1] = false

n = 2
while n * n < LIMIT
  if is_prime[n]
    multiple = n * n
    while multiple < LIMIT
      is_prime[multiple] = false
      multiple += n
    end
  end
  n += 1
end

primes = (0...LIMIT).select { |value| is_prime[value] }
puts primes.join(" ")
