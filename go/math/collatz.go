// collatz.go: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     go run collatz.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

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
