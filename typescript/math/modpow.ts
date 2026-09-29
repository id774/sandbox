// modpow.ts: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
// Usage:
//     tsc --target es2020 modpow.ts && node modpow.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

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
