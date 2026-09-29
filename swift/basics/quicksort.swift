// quicksort.swift: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort generic over any Comparable element.
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
//     swift quicksort.swift
//
// Requirements:
// - Swift 5.1 or later
// - No third-party package is required

func quicksort<T: Comparable>(_ items: [T]) -> [T] {
    guard let pivot = items.first else { return [] }
    let rest = items.dropFirst()
    return quicksort(rest.filter { $0 <= pivot }) + [pivot] + quicksort(rest.filter { $0 > pivot })
}

let numbers = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6]
print(quicksort(numbers).map { String($0) }.joined(separator: " "))
