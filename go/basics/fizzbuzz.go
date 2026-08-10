// Print FizzBuzz for 1 through 100, choosing the label in a switch with no condition.
// Run: go run fizzbuzz.go

package main

import "fmt"

func label(n int) string {
	switch {
	case n%15 == 0:
		return "FizzBuzz"
	case n%3 == 0:
		return "Fizz"
	case n%5 == 0:
		return "Buzz"
	default:
		return fmt.Sprint(n)
	}
}

func main() {
	for n := 1; n <= 100; n++ {
		fmt.Println(label(n))
	}
}
