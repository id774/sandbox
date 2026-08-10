// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: node word_frequency.js

const text = "the quick brown fox jumps over the lazy dog the fox barks";

const counts = new Map();
for (const word of text.split(/\s+/)) {
  counts.set(word, (counts.get(word) ?? 0) + 1);
}

const ranked = [...counts].sort(
  (a, b) => b[1] - a[1] || (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0),
);
for (const [word, count] of ranked) {
  console.log(`${word} ${count}`);
}
