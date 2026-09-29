# modpow.nim: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
#     nim c -r modpow.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

const Cases = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

proc modpow(base, exponent, modulus: int): int =
  var
    factor = base mod modulus
    power = exponent
  result = 1
  while power > 0:
    if power mod 2 == 1:
      result = result * factor mod modulus
    factor = factor * factor mod modulus
    power = power div 2

for (base, exponent, modulus) in Cases:
  echo base, " ", exponent, " ", modulus, " ", modpow(base, exponent, modulus)
