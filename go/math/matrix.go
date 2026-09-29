// matrix.go: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices held as arrays of arrays rather than slices.
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
//     go run matrix.go
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

const size = 3

type matrix [size][size]int

var (
	left  = matrix{{2, -1, 0}, {1, 3, 4}, {0, 5, -2}}
	right = matrix{{1, 0, 2}, {-3, 1, 1}, {4, 2, 0}}
)

func multiply(a, b matrix) matrix {
	var product matrix
	for i := 0; i < size; i++ {
		for j := 0; j < size; j++ {
			for k := 0; k < size; k++ {
				product[i][j] += a[i][k] * b[k][j]
			}
		}
	}
	return product
}

func determinant(m matrix) int {
	return m[0][0]*(m[1][1]*m[2][2]-m[1][2]*m[2][1]) -
		m[0][1]*(m[1][0]*m[2][2]-m[1][2]*m[2][0]) +
		m[0][2]*(m[1][0]*m[2][1]-m[1][1]*m[2][0])
}

func main() {
	product := multiply(left, right)

	for _, row := range product {
		fields := make([]string, size)
		for j, value := range row {
			fields[j] = strconv.Itoa(value)
		}
		fmt.Println(strings.Join(fields, " "))
	}
	fmt.Println(determinant(product))
}
