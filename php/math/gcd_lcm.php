<?php
// gcd_lcm.php: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a loop.
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
//     php gcd_lcm.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

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
