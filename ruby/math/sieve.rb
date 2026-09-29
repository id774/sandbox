#!/usr/bin/env ruby
# sieve.rb: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over an array of flags stepped by each prime found.
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
#     ruby sieve.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

LIMIT = 100

is_prime = Array.new(LIMIT, true)
is_prime[0] = is_prime[1] = false

(2..Integer.sqrt(LIMIT)).each do |n|
  next unless is_prime[n]

  (n * n).step(LIMIT - 1, n) { |multiple| is_prime[multiple] = false }
end

puts is_prime.each_index.select { |n| is_prime[n] }.join(' ')
