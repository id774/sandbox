// fizzbuzz.rs: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, branching with match on a tuple of remainders.
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
//     rustc -o fizzbuzz fizzbuzz.rs
//     ./fizzbuzz
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

fn main() {
    for n in 1..=100 {
        let line = match (n % 3, n % 5) {
            (0, 0) => "FizzBuzz".to_string(),
            (0, _) => "Fizz".to_string(),
            (_, 0) => "Buzz".to_string(),
            _ => n.to_string(),
        };
        println!("{}", line);
    }
}
