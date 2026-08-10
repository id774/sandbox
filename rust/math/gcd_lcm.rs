// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
// Build: rustc -o gcd_lcm gcd_lcm.rs

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
