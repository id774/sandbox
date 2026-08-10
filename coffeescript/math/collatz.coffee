# Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
# Run: coffee collatz.coffee

limit = 1000

chainLength = (start) ->
  value = start
  length = 1
  while value isnt 1
    value = if value % 2 is 0 then value / 2 else value * 3 + 1
    length++
  length

longest = 1
best = 1

for start in [1...limit]
  length = chainLength(start)
  if length > best
    longest = start
    best = length

console.log "#{longest} #{best}"
