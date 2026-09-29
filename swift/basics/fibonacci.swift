// fibonacci.swift: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a sequence unfolded out of a pair of states.
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
//     swift fibonacci.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let fibonacci = sequence(state: (0, 1)) { (state: inout (Int, Int)) -> Int? in
    let value = state.0
    state = (state.1, state.0 + state.1)
    return value
}

print(fibonacci.prefix(20).map { String($0) }.joined(separator: " "))
