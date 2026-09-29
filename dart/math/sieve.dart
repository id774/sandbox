// sieve.dart: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a list of flags and gathered by a list comprehension.
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
//     dart run sieve.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

const limit = 100;

void main() {
  final isPrime = List<bool>.filled(limit, true);
  isPrime[0] = false;
  isPrime[1] = false;

  for (var n = 2; n * n < limit; n++) {
    if (!isPrime[n]) continue;
    for (var multiple = n * n; multiple < limit; multiple += n) {
      isPrime[multiple] = false;
    }
  }

  final primes = [
    for (var n = 0; n < limit; n++)
      if (isPrime[n]) n,
  ];
  print(primes.join(' '));
}
