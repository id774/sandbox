// Print modular powers of fixed triples, each squared and halved by repeated squaring.
// Run: swift modpow.swift

let cases = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

func modpow(_ base: Int, _ exponent: Int, _ modulus: Int) -> Int {
    var factor = base % modulus
    var power = exponent
    var result = 1

    while power > 0 {
        if power % 2 == 1 {
            result = result * factor % modulus
        }
        factor = factor * factor % modulus
        power /= 2
    }
    return result
}

for (base, exponent, modulus) in cases {
    print("\(base) \(exponent) \(modulus) \(modpow(base, exponent, modulus))")
}
