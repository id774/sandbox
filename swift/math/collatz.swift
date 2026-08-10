// Print the start below 1000 with the longest Collatz sequence, picked by max(by:) over a range.
// Run: swift collatz.swift

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
