// Sort a fixed slice with a quicksort generic over any ordered element type.
// Run: go run quicksort.go

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
