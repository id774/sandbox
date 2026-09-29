// modpow.go: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
//     go run modpow.go
//
// Requirements:
// - Go 1.21 or later
// - No third-party package is required

package main

import "fmt"

var cases = [][3]int64{{2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}}

func modpow(base, exponent, modulus int64) int64 {
	result := int64(1)
	base %= modulus
	for exponent > 0 {
		if exponent%2 == 1 {
			result = result * base % modulus
		}
		base = base * base % modulus
		exponent /= 2
	}
	return result
}

func main() {
	for _, c := range cases {
		base, exponent, modulus := c[0], c[1], c[2]
		fmt.Println(base, exponent, modulus, modpow(base, exponent, modulus))
	}
}
