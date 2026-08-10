// Print the first 20 Fibonacci numbers, produced by a closure that carries the state.
// Run: go run fibonacci.go

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
