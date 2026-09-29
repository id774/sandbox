// pascal.go: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row grown by append and accumulated from the back.
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
//     go run pascal.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

package main

import (
	"fmt"
	"strconv"
	"strings"
)

const rows = 10

func main() {
	row := []int{1}

	for length := 1; length <= rows; length++ {
		fields := make([]string, len(row))
		for i, value := range row {
			fields[i] = strconv.Itoa(value)
		}
		fmt.Println(strings.Join(fields, " "))

		row = append(row, 0)
		for i := len(row) - 1; i > 0; i-- {
			row[i] += row[i-1]
		}
	}
}
