<?php
// modpow.php: Modular exponentiation of fixed triples by repeated squaring
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
//     php modpow.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

declare(strict_types=1);

const CASES = [[2, 1000, 1000003], [3, 200, 50], [5, 117, 19], [10, 18, 9999991]];

function modpow(int $base, int $exponent, int $modulus): int
{
    $result = 1;
    $base %= $modulus;
    while ($exponent > 0) {
        if ($exponent % 2 === 1) {
            $result = $result * $base % $modulus;
        }
        $base = $base * $base % $modulus;
        $exponent >>= 1;
    }

    return $result;
}

foreach (CASES as [$base, $exponent, $modulus]) {
    printf("%d %d %d %d\n", $base, $exponent, $modulus, modpow($base, $exponent, $modulus));
}
