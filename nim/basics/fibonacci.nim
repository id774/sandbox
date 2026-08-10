# Print the first 20 Fibonacci numbers from an inline iterator.
# Run: nim c -r fibonacci.nim

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
