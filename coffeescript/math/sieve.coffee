# sieve.coffee: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags built by a comprehension.
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
#     coffee sieve.coffee
#
# Requirements:
# - CoffeeScript 2.0 or later (coffee)
# - Node.js 20 or later
# - No third-party package is required

limit = 100

isPrime = (n >= 2 for n in [0...limit])

n = 2
while n * n < limit
  if isPrime[n]
    multiple = n * n
    while multiple < limit
      isPrime[multiple] = false
      multiple += n
  n++

primes = (n for n in [0...limit] when isPrime[n])
console.log primes.join ' '
