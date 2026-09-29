// pascal.swift: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
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
//     swift pascal.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

let rows = 10

var row = [1]
for _ in 0..<rows {
    print(row.map(String.init).joined(separator: " "))
    row = zip([0] + row, row + [0]).map { $0 + $1 }
}
