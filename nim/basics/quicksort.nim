# Sort a fixed sequence with a quicksort generic over any ordered element type.
# Run: nim c -r quicksort.nim

import std/[sequtils, strutils]

proc quicksort[T](items: seq[T]): seq[T] =
  if items.len <= 1:
    return items
  let pivot = items[0]
  let rest = items[1 .. ^1]
  quicksort(rest.filterIt(it <= pivot)) & @[pivot] & quicksort(rest.filterIt(it > pivot))

echo quicksort(@[5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).mapIt($it).join(" ")
