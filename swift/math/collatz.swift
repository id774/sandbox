// collatz.swift: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, picked by max(by:) over a range.
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
//     swift collatz.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let limit = 1000

func chainLength(_ start: Int) -> Int {
    var value = start
    var length = 1
    while value != 1 {
        value = value.isMultiple(of: 2) ? value / 2 : value * 3 + 1
        length += 1
    }
    return length
}

let longest = (1..<limit).max { chainLength($0) < chainLength($1) }!
print("\(longest) \(chainLength(longest))")
