// gcd_lcm.rs: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
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
//     rustc -o gcd_lcm gcd_lcm.rs
//     ./gcd_lcm
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

const PAIRS: [(u64, u64); 4] = [(1071, 462), (270, 192), (17, 5), (120, 36)];

fn gcd(mut first: u64, mut second: u64) -> u64 {
    while second != 0 {
        let remainder = first % second;
        first = second;
        second = remainder;
    }
    first
}

fn main() {
    for (first, second) in PAIRS {
        let divisor = gcd(first, second);
        println!("{} {} {} {}", first, second, divisor, first / divisor * second);
    }
}
