# gcd_lcm.nim: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
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
#     nim c -r gcd_lcm.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

const Pairs = [(1071, 462), (270, 192), (17, 5), (120, 36)]

proc euclid(first, second: int): int =
  var
    a = first
    b = second
  while b != 0:
    let remainder = a mod b
    a = b
    b = remainder
  a

for (first, second) in Pairs:
  let divisor = euclid(first, second)
  echo first, " ", second, " ", divisor, " ", first div divisor * second
