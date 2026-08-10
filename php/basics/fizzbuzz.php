<?php
// Print FizzBuzz for 1 through 100, choosing the label with a match expression.

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
