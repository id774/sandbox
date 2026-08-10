// Print the primes below 100, sieved over a slice of flags and gathered by append.
// Run: go run sieve.go

package main

import (
	"fmt"
	"strconv"
	"strings"
)

const limit = 100

func main() {
	isPrime := make([]bool, limit)
	for n := 2; n < limit; n++ {
		isPrime[n] = true
	}

	for n := 2; n*n < limit; n++ {
		if !isPrime[n] {
			continue
		}
		for multiple := n * n; multiple < limit; multiple += n {
			isPrime[multiple] = false
		}
	}

	var primes []string
	for n, prime := range isPrime {
		if prime {
			primes = append(primes, strconv.Itoa(n))
		}
	}
	fmt.Println(strings.Join(primes, " "))
}
