// fibonacci.dart: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a sync* generator.
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
//     dart run fibonacci.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

Iterable<int> fibonacci() sync* {
  var current = 0;
  var next = 1;
  while (true) {
    yield current;
    final following = current + next;
    current = next;
    next = following;
  }
}

void main() {
  print(fibonacci().take(20).join(' '));
}
