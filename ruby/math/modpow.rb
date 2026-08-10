#!/usr/bin/env ruby
# Print modular powers of fixed triples, each squared and halved rather than left to pow.

CASES = [[2, 1000, 1000003], [3, 200, 50], [5, 117, 19], [10, 18, 9999991]].freeze

def modpow(base, exponent, modulus)
  result = 1
  base %= modulus
  until exponent.zero?
    result = result * base % modulus if exponent.odd?
    base = base * base % modulus
    exponent >>= 1
  end
  result
end

CASES.each do |base, exponent, modulus|
  puts "#{base} #{exponent} #{modulus} #{modpow(base, exponent, modulus)}"
end
