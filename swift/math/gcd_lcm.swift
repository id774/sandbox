// gcd_lcm.swift: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
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
//     swift gcd_lcm.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let pairs = [(1071, 462), (270, 192), (17, 5), (120, 36)]

func euclid(_ first: Int, _ second: Int) -> Int {
    var first = first
    var second = second
    while second != 0 {
        (first, second) = (second, first % second)
    }
    return first
}

for (first, second) in pairs {
    let divisor = euclid(first, second)
    print("\(first) \(second) \(divisor) \(first / divisor * second)")
}
