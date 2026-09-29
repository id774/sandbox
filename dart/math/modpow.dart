// modpow.dart: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
//     dart run modpow.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

const cases = [
  [2, 1000, 1000003],
  [3, 200, 50],
  [5, 117, 19],
  [10, 18, 9999991],
];

int modpow(int base, int exponent, int modulus) {
  var result = 1;
  base %= modulus;

  while (exponent > 0) {
    if (exponent.isOdd) result = result * base % modulus;
    base = base * base % modulus;
    exponent ~/= 2;
  }
  return result;
}

void main() {
  for (final triple in cases) {
    final base = triple[0];
    final exponent = triple[1];
    final modulus = triple[2];
    print('$base $exponent $modulus ${modpow(base, exponent, modulus)}');
  }
}
