// Print modular powers of fixed triples, each squared and halved by repeated squaring.
// Run: go run modpow.go

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
