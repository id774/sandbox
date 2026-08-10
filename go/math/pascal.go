// Print 10 rows of Pascal's triangle, each row grown by append and accumulated from the back.
// Run: go run pascal.go

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
