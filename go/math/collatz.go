// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Run: go run collatz.go

package main

import "fmt"

const limit = 1000

func chainLength(start int) int {
	length := 1
	for start != 1 {
		if start%2 == 0 {
			start /= 2
		} else {
			start = start*3 + 1
		}
		length++
	}
	return length
}

func main() {
	longest, best := 1, 1
	for start := 1; start < limit; start++ {
		if length := chainLength(start); length > best {
			longest, best = start, length
		}
	}
	fmt.Println(longest, best)
}
