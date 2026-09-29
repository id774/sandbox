// sieve.js: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over an array of flags and collected with reduce.
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
//     node sieve.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required

const LIMIT = 100;

const isPrime = new Array(LIMIT).fill(true);
isPrime[0] = isPrime[1] = false;

for (let n = 2; n * n < LIMIT; n++) {
  if (!isPrime[n]) continue;
  for (let multiple = n * n; multiple < LIMIT; multiple += n) {
    isPrime[multiple] = false;
  }
}

const primes = isPrime.reduce((found, prime, n) => (prime ? [...found, n] : found), []);
console.log(primes.join(" "));
