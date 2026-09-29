// modpow.swift: Modular exponentiation of fixed triples by repeated squaring
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
//     swift modpow.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let cases = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

func modpow(_ base: Int, _ exponent: Int, _ modulus: Int) -> Int {
    var factor = base % modulus
    var power = exponent
    var result = 1

    while power > 0 {
        if power % 2 == 1 {
            result = result * factor % modulus
        }
        factor = factor * factor % modulus
        power /= 2
    }
    return result
}

for (base, exponent, modulus) in cases {
    print("\(base) \(exponent) \(modulus) \(modpow(base, exponent, modulus))")
}
