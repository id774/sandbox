# fibonacci.nim: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers from an inline iterator.
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
#     nim c -r fibonacci.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

import std/[sequtils, strutils]

iterator fibonacci(count: int): int =
  var current = 0
  var next = 1
  for _ in 1 .. count:
    yield current
    let following = current + next
    current = next
    next = following

echo toSeq(fibonacci(20)).mapIt($it).join(" ")
