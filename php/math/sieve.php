<?php
// sieve.php: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over an array of flags and read back with array_keys.
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
//     php sieve.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

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
