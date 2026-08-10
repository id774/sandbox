<?php
// Print the primes below 100, sieved over an array of flags and read back with array_keys.

declare(strict_types=1);

const LIMIT = 100;

$isPrime = array_fill(0, LIMIT, true);
$isPrime[0] = $isPrime[1] = false;

for ($n = 2; $n * $n < LIMIT; $n++) {
    if (!$isPrime[$n]) {
        continue;
    }
    for ($multiple = $n * $n; $multiple < LIMIT; $multiple += $n) {
        $isPrime[$multiple] = false;
    }
}

echo implode(' ', array_keys($isPrime, true, true)), "\n";
