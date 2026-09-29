// sieve.swift: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over an array of flags indexed by the number itself.
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
//     swift sieve.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let limit = 100

var isPrime = [Bool](repeating: true, count: limit)
isPrime[0] = false
isPrime[1] = false

var n = 2
while n * n < limit {
    if isPrime[n] {
        var multiple = n * n
        while multiple < limit {
            isPrime[multiple] = false
            multiple += n
        }
    }
    n += 1
}

print((0..<limit).filter { isPrime[$0] }.map(String.init).joined(separator: " "))
