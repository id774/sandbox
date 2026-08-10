// Print the first 20 Fibonacci numbers from a sequence unfolded out of a pair of states.
// Run: swift fibonacci.swift

let fibonacci = sequence(state: (0, 1)) { (state: inout (Int, Int)) -> Int? in
    let value = state.0
    state = (state.1, state.0 + state.1)
    return value
}

print(fibonacci.prefix(20).map { String($0) }.joined(separator: " "))
