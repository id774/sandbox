// word_frequency.go: Word frequencies of a fixed sentence
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
//     go run word_frequency.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

package main

import (
	"cmp"
	"fmt"
	"slices"
	"strings"
)

const text = "the quick brown fox jumps over the lazy dog the fox barks"

type entry struct {
	word  string
	count int
}

func main() {
	counts := map[string]int{}
	for _, word := range strings.Fields(text) {
		counts[word]++
	}

	ranked := make([]entry, 0, len(counts))
	for word, count := range counts {
		ranked = append(ranked, entry{word: word, count: count})
	}
	slices.SortFunc(ranked, func(a, b entry) int {
		if a.count != b.count {
			return cmp.Compare(b.count, a.count)
		}
		return cmp.Compare(a.word, b.word)
	})

	for _, item := range ranked {
		fmt.Println(item.word, item.count)
	}
}
