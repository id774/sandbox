// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a parallel assignment.
// Run: go run gcd_lcm.go

package main

import "fmt"

var pairs = [][2]int{{1071, 462}, {270, 192}, {17, 5}, {120, 36}}

func gcd(first, second int) int {
	for second != 0 {
		first, second = second, first%second
	}
	return first
}

func main() {
	for _, pair := range pairs {
		first, second := pair[0], pair[1]
		divisor := gcd(first, second)
		fmt.Println(first, second, divisor, first/divisor*second)
	}
}
