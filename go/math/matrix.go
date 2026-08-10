// Multiply two fixed 3x3 integer matrices held as arrays of arrays rather than slices.
// Run: go run matrix.go

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
