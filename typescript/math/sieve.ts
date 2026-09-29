// sieve.ts: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a typed array of flags.
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
//     tsc --target es2020 sieve.ts && node sieve.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

const limit = 100;

const isPrime: boolean[] = new Array(limit).fill(true);
isPrime[0] = false;
isPrime[1] = false;

for (let n = 2; n * n < limit; n++) {
    if (!isPrime[n]) continue;
    for (let multiple = n * n; multiple < limit; multiple += n) {
        isPrime[multiple] = false;
    }
}

const primes: number[] = [];
isPrime.forEach((prime, n) => {
    if (prime) primes.push(n);
});

console.log(primes.join(" "));
