// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: go run word_frequency.go

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
