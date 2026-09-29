// fibonacci.rs: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a hand-written Iterator implementation.
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
// Build / Run:
//     rustc -o fibonacci fibonacci.rs
//     ./fibonacci
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

struct Fibonacci {
    current: u64,
    next: u64,
}

impl Iterator for Fibonacci {
    type Item = u64;

    fn next(&mut self) -> Option<u64> {
        let value = self.current;
        self.current = self.next;
        self.next += value;
        Some(value)
    }
}

fn main() {
    let fib = Fibonacci {
        current: 0,
        next: 1,
    };
    let values: Vec<String> = fib.take(20).map(|n| n.to_string()).collect();
    println!("{}", values.join(" "));
}
