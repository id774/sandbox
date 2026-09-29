// fibonacci.go: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers, produced by a closure that carries the state.
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
//     go run fibonacci.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

package main

import (
	"fmt"
	"strings"
)

func fibonacci() func() uint64 {
	current, next := uint64(0), uint64(1)
	return func() uint64 {
		value := current
		current, next = next, current+next
		return value
	}
}

func main() {
	step := fibonacci()
	values := make([]string, 0, 20)
	for i := 0; i < 20; i++ {
		values = append(values, fmt.Sprint(step()))
	}
	fmt.Println(strings.Join(values, " "))
}
