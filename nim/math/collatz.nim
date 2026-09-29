# collatz.nim: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
#     nim c -r collatz.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

const Limit = 1000

proc chainLength(start: int): int =
  var
    value = start
    length = 1
  while value != 1:
    value = if value mod 2 == 0: value div 2 else: value * 3 + 1
    inc length
  length

var
  longest = 1
  best = 1

for start in 1 ..< Limit:
  let length = chainLength(start)
  if length > best:
    longest = start
    best = length

echo longest, " ", best
