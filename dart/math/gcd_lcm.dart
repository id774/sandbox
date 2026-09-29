// gcd_lcm.dart: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     dart run gcd_lcm.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

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
