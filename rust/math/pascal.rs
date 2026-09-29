// pascal.rs: The first 10 rows of Pascal's triangle
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
// Build / Run:
//     rustc -o pascal pascal.rs
//     ./pascal
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

const ROWS: usize = 10;

fn main() {
    let mut row: Vec<u64> = vec![1];

    for _ in 0..ROWS {
        let fields: Vec<String> = row.iter().map(|value| value.to_string()).collect();
        println!("{}", fields.join(" "));

        let shifted = std::iter::once(&0).chain(row.iter());
        let padded = row.iter().chain(std::iter::once(&0));
        row = shifted.zip(padded).map(|(left, right)| left + right).collect();
    }
}
