<?php
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a loop.

declare(strict_types=1);

const PAIRS = [[1071, 462], [270, 192], [17, 5], [120, 36]];

function gcd(int $first, int $second): int
{
    while ($second !== 0) {
        [$first, $second] = [$second, $first % $second];
    }

    return $first;
}

foreach (PAIRS as [$first, $second]) {
    $divisor = gcd($first, $second);
    printf("%d %d %d %d\n", $first, $second, $divisor, intdiv($first, $divisor) * $second);
}
