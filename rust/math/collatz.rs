// Print the start below 1000 with the longest Collatz sequence, picked by max_by_key over a range.
// Build: rustc -o collatz collatz.rs

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
