// sieve.rs: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a vector of flags and collected from an iterator.
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
//     rustc -o sieve sieve.rs
//     ./sieve
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

const LIMIT: usize = 100;

fn main() {
    let mut is_prime = vec![true; LIMIT];
    is_prime[0] = false;
    is_prime[1] = false;

    let mut n = 2;
    while n * n < LIMIT {
        if is_prime[n] {
            let mut multiple = n * n;
            while multiple < LIMIT {
                is_prime[multiple] = false;
                multiple += n;
            }
        }
        n += 1;
    }

    let primes: Vec<String> = is_prime
        .iter()
        .enumerate()
        .filter(|(_, &prime)| prime)
        .map(|(n, _)| n.to_string())
        .collect();

    println!("{}", primes.join(" "));
}
