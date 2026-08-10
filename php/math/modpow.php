<?php
// Print modular powers of fixed triples, each squared and halved by repeated squaring.

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
