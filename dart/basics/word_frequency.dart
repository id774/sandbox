// word_frequency.dart: Word frequencies of a fixed sentence
//
// Description:
// Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
//     dart run word_frequency.dart
//
// Requirements:
// - Dart 3.0 or later
// - No third-party package is required

const text = 'the quick brown fox jumps over the lazy dog the fox barks';

void main() {
  final counts = <String, int>{};
  for (final word in text.split(RegExp(r'\s+'))) {
    counts.update(word, (value) => value + 1, ifAbsent: () => 1);
  }

  final ranked = counts.entries.toList()
    ..sort((a, b) {
      final byCount = b.value.compareTo(a.value);
      return byCount != 0 ? byCount : a.key.compareTo(b.key);
    });

  for (final entry in ranked) {
    print('${entry.key} ${entry.value}');
  }
}
