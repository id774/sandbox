<?php
// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.

declare(strict_types=1);

const LIMIT = 1000;

function chainLength(int $start): int
{
    $length = 1;
    while ($start !== 1) {
        $start = $start % 2 === 0 ? intdiv($start, 2) : $start * 3 + 1;
        $length++;
    }

    return $length;
}

$longest = 1;
$best = 1;

for ($start = 1; $start < LIMIT; $start++) {
    $length = chainLength($start);
    if ($length > $best) {
        $longest = $start;
        $best = $length;
    }
}

echo "$longest $best\n";
