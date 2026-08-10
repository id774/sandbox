// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a destructured swap.
// Run: node gcd_lcm.js

const pairs = [
  [1071, 462],
  [270, 192],
  [17, 5],
  [120, 36],
];

function gcd(first, second) {
  while (second !== 0) {
    [first, second] = [second, first % second];
  }
  return first;
}

for (const [first, second] of pairs) {
  const divisor = gcd(first, second);
  console.log(`${first} ${second} ${divisor} ${(first / divisor) * second}`);
}
