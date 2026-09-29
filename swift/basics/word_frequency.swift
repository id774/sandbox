// word_frequency.swift: Word frequencies of a fixed sentence
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
//     swift word_frequency.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let text = "the quick brown fox jumps over the lazy dog the fox barks"

var counts: [String: Int] = [:]
for word in text.split(separator: " ") {
    counts[String(word), default: 0] += 1
}

let ranked = counts.sorted { left, right in
    left.value == right.value ? left.key < right.key : left.value > right.value
}
for (word, count) in ranked {
    print("\(word) \(count)")
}
