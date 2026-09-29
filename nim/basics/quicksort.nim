# quicksort.nim: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed sequence with a quicksort generic over any ordered element type.
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
#     nim c -r quicksort.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

import std/[sequtils, strutils]

proc quicksort[T](items: seq[T]): seq[T] =
  if items.len <= 1:
    return items
  let pivot = items[0]
  let rest = items[1 .. ^1]
  quicksort(rest.filterIt(it <= pivot)) & @[pivot] & quicksort(rest.filterIt(it > pivot))

echo quicksort(@[5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).mapIt($it).join(" ")
