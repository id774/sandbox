// word_frequency.rs: Word frequencies of a fixed sentence
//
// Description:
// Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
//     rustc -o word_frequency word_frequency.rs
//     ./word_frequency
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

use std::collections::HashMap;

const TEXT: &str = "the quick brown fox jumps over the lazy dog the fox barks";

fn main() {
    let mut counts: HashMap<&str, usize> = HashMap::new();
    for word in TEXT.split_whitespace() {
        *counts.entry(word).or_insert(0) += 1;
    }

    let mut pairs: Vec<(&str, usize)> = counts.into_iter().collect();
    pairs.sort_by(|a, b| b.1.cmp(&a.1).then(a.0.cmp(b.0)));

    for (word, count) in pairs {
        println!("{} {}", word, count);
    }
}
