#!/usr/bin/env ruby
# Print the primes below 100, sieved over an array of flags stepped by each prime found.

LIMIT = 100

is_prime = Array.new(LIMIT, true)
is_prime[0] = is_prime[1] = false

(2..Integer.sqrt(LIMIT)).each do |n|
  next unless is_prime[n]

  (n * n).step(LIMIT - 1, n) { |multiple| is_prime[multiple] = false }
end

puts is_prime.each_index.select { |n| is_prime[n] }.join(' ')
