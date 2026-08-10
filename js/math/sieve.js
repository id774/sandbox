// Print the primes below 100, sieved over an array of flags and collected with reduce.
// Run: node sieve.js

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
