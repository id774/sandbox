// quicksort.dart: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed list with a quicksort generic over any Comparable element.
// The bound is Comparable<dynamic> because int implements Comparable<num>, not Comparable<int>.
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
//     dart run quicksort.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

List<T> quicksort<T extends Comparable<dynamic>>(List<T> items) {
  if (items.length <= 1) return List<T>.of(items);
  final pivot = items.first;
  final rest = items.skip(1);
  final smaller = rest.where((x) => x.compareTo(pivot) <= 0).toList();
  final larger = rest.where((x) => x.compareTo(pivot) > 0).toList();
  return [...quicksort(smaller), pivot, ...quicksort(larger)];
}

void main() {
  final numbers = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
  print(quicksort(numbers).join(' '));
}
