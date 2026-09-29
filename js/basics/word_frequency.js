// word_frequency.js: Word frequencies of a fixed sentence
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
//     node word_frequency.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required

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
