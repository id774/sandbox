# modpow.cr: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# The values are Int64 because the squares outgrow the Int32 that a literal would give.
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
#     crystal run modpow.cr
#
# Requirements:
# - Crystal 1.0 or later
# - No third-party package is required

CASES = [
  {2_i64, 1000_i64, 1000003_i64},
  {3_i64, 200_i64, 50_i64},
  {5_i64, 117_i64, 19_i64},
  {10_i64, 18_i64, 9999991_i64},
]

def modpow(base : Int64, exponent : Int64, modulus : Int64) : Int64
  result = 1_i64
  base %= modulus
  while exponent > 0
    result = result * base % modulus if exponent.odd?
    base = base * base % modulus
    exponent //= 2
  end
  result
end

CASES.each do |(base, exponent, modulus)|
  puts "#{base} #{exponent} #{modulus} #{modpow(base, exponent, modulus)}"
end
