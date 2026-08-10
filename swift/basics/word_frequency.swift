// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: swift word_frequency.swift

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
