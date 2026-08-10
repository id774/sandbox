// Print the primes below 100, sieved over a vector of flags and collected from an iterator.
// Build: rustc -o sieve sieve.rs

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
