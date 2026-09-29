<?php
// fibonacci.php: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a generator.
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
//     php fibonacci.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

declare(strict_types=1);

function fibonacci(int $count): Generator
{
    $current = 0;
    $next = 1;
    for ($i = 0; $i < $count; $i++) {
        yield $current;
        [$current, $next] = [$next, $current + $next];
    }
}

echo implode(' ', iterator_to_array(fibonacci(20))), PHP_EOL;
