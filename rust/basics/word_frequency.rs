// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Build: rustc -o word_frequency word_frequency.rs

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
