// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
// Run: dart run gcd_lcm.dart

const pairs = [
  [1071, 462],
  [270, 192],
  [17, 5],
  [120, 36],
];

int euclid(int first, int second) {
  while (second != 0) {
    final remainder = first % second;
    first = second;
    second = remainder;
  }
  return first;
}

void main() {
  for (final pair in pairs) {
    final first = pair[0];
    final second = pair[1];
    final divisor = euclid(first, second);
    print('$first $second $divisor ${first ~/ divisor * second}');
  }
}
