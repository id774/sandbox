# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a destructured swap.
# Run: coffee gcd_lcm.coffee

pairs = [[1071, 462], [270, 192], [17, 5], [120, 36]]

gcd = (first, second) ->
  while second isnt 0
    [first, second] = [second, first % second]
  first

for [first, second] in pairs
  divisor = gcd(first, second)
  console.log "#{first} #{second} #{divisor} #{first / divisor * second}"
