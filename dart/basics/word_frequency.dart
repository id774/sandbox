// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: dart run word_frequency.dart

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
