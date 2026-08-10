// Print modular powers of fixed triples, each squared and halved by repeated squaring.
// Run: tsc --target es2020 modpow.ts && node modpow.js

const cases: [number, number, number][] = [
    [2, 1000, 1000003],
    [3, 200, 50],
    [5, 117, 19],
    [10, 18, 9999991],
];

function modpow(base: number, exponent: number, modulus: number): number {
    let result = 1;
    base %= modulus;
    while (exponent > 0) {
        if (exponent % 2 === 1) result = (result * base) % modulus;
        base = (base * base) % modulus;
        exponent = Math.floor(exponent / 2);
    }
    return result;
}

for (const [base, exponent, modulus] of cases) {
    console.log(`${base} ${exponent} ${modulus} ${modpow(base, exponent, modulus)}`);
}
