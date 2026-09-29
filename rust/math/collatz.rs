// collatz.rs: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, picked by max_by_key over a range.
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
// Build / Run:
//     rustc -o collatz collatz.rs
//     ./collatz
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

const LIMIT: u64 = 1000;

fn chain_length(start: u64) -> u32 {
    let mut value = start;
    let mut length = 1;

    while value != 1 {
        value = if value % 2 == 0 { value / 2 } else { value * 3 + 1 };
        length += 1;
    }
    length
}

fn main() {
    let longest = (1..LIMIT).max_by_key(|&start| chain_length(start)).unwrap();
    println!("{} {}", longest, chain_length(longest));
}
