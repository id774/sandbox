// Print modular powers of fixed triples, each squared and shifted down by repeated squaring.
// Build: rustc -o modpow modpow.rs

const CASES: [(u64, u64, u64); 4] = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)];

fn modpow(mut base: u64, mut exponent: u64, modulus: u64) -> u64 {
    let mut result = 1;

    base %= modulus;
    while exponent > 0 {
        if exponent & 1 == 1 {
            result = result * base % modulus;
        }
        base = base * base % modulus;
        exponent >>= 1;
    }
    result
}

fn main() {
    for (base, exponent, modulus) in CASES {
        println!("{} {} {} {}", base, exponent, modulus, modpow(base, exponent, modulus));
    }
}
