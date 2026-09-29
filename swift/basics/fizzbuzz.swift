// fizzbuzz.swift: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, choosing the label with a switch over a tuple.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     swift fizzbuzz.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

func fizzBuzzLabel(_ n: Int) -> String {
    switch (n % 3, n % 5) {
    case (0, 0): return "FizzBuzz"
    case (0, _): return "Fizz"
    case (_, 0): return "Buzz"
    default: return String(n)
    }
}

for n in 1...100 {
    print(fizzBuzzLabel(n))
}
