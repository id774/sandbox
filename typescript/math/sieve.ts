// Print the primes below 100, sieved over a typed array of flags.
// Run: tsc --target es2020 sieve.ts && node sieve.js

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
