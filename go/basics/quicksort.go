// quicksort.go: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed slice with a quicksort generic over any ordered element type.
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
//     go run quicksort.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

package main

import (
	"cmp"
	"fmt"
	"strings"
)

func quicksort[T cmp.Ordered](items []T) []T {
	if len(items) <= 1 {
		return append([]T(nil), items...)
	}

	pivot, rest := items[0], items[1:]
	var smaller, larger []T
	for _, value := range rest {
		if value <= pivot {
			smaller = append(smaller, value)
		} else {
			larger = append(larger, value)
		}
	}

	sorted := quicksort(smaller)
	sorted = append(sorted, pivot)
	return append(sorted, quicksort(larger)...)
}

func main() {
	numbers := []int{5, 3, 8, 4, 2, 7, 1, 10, 9, 6}
	values := make([]string, 0, len(numbers))
	for _, value := range quicksort(numbers) {
		values = append(values, fmt.Sprint(value))
	}
	fmt.Println(strings.Join(values, " "))
}
