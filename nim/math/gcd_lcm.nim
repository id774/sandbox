# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
# Run: nim c -r gcd_lcm.nim

const Pairs = [(1071, 462), (270, 192), (17, 5), (120, 36)]

proc euclid(first, second: int): int =
  var
    a = first
    b = second
  while b != 0:
    let remainder = a mod b
    a = b
    b = remainder
  a

for (first, second) in Pairs:
  let divisor = euclid(first, second)
  echo first, " ", second, " ", divisor, " ", first div divisor * second
