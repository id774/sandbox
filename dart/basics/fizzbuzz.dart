// fizzbuzz.dart: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, choosing the label with a switch expression on a record.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     dart run fizzbuzz.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

String fizzBuzzLabel(int n) => switch ((n % 3, n % 5)) {
      (0, 0) => 'FizzBuzz',
      (0, _) => 'Fizz',
      (_, 0) => 'Buzz',
      _ => '$n',
    };

void main() {
  for (var n = 1; n <= 100; n++) {
    print(fizzBuzzLabel(n));
  }
}
