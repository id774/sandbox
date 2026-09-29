#!/usr/bin/env ruby
# modpow.rb: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved rather than left to pow.
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
#     ruby modpow.rb
#
# Requirements:
# - Ruby 3.0 or later
# - No third-party package is required

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
