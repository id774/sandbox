# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
# Run: nim c -r collatz.nim

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
