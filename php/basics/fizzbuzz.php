<?php
// fizzbuzz.php: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, choosing the label with a match expression.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     php fizzbuzz.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

declare(strict_types=1);

function label(int $n): string
{
    return match (true) {
        $n % 15 === 0 => 'FizzBuzz',
        $n % 3 === 0 => 'Fizz',
        $n % 5 === 0 => 'Buzz',
        default => (string) $n,
    };
}

for ($n = 1; $n <= 100; $n++) {
    echo label($n), PHP_EOL;
}
