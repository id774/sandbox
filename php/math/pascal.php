<?php
// Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.

declare(strict_types=1);

const ROWS = 10;

$row = [1];

for ($i = 0; $i < ROWS; $i++) {
    echo implode(' ', $row), "\n";
    $row = array_map(
        static fn (int $left, int $right): int => $left + $right,
        [0, ...$row],
        [...$row, 0]
    );
}
