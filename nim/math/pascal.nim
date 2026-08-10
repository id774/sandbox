# Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
# Run: nim c -r pascal.nim

import std/[sequtils, strutils]

const Rows = 10

var row = @[1]
for _ in 0 ..< Rows:
  echo row.mapIt($it).join(" ")
  row = zip(@[0] & row, row & @[0]).mapIt(it[0] + it[1])
