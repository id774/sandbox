// gcd_lcm.go: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a parallel assignment.
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
//     go run gcd_lcm.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

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
