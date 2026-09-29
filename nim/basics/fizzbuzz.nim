# fizzbuzz.nim: FizzBuzz for 1 through 100
#
# Description:
# Print FizzBuzz for 1 through 100, with the label returned by an if expression.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nim c -r fizzbuzz.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

proc fizzBuzzLabel(n: int): string =
  if n mod 15 == 0: "FizzBuzz"
  elif n mod 3 == 0: "Fizz"
  elif n mod 5 == 0: "Buzz"
  else: $n

for n in 1 .. 100:
  echo fizzBuzzLabel(n)
