<?php
// Print the first 20 Fibonacci numbers from a generator.

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
