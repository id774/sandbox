<?php
// Multiply two fixed 3x3 integer matrices, with the inner product folded by array_sum over array_map.

declare(strict_types=1);

const LEFT = [[2, -1, 0], [1, 3, 4], [0, 5, -2]];
const RIGHT = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]];

function multiply(array $left, array $right): array
{
    $columns = array_map(null, ...$right);

    return array_map(
        static fn (array $row): array => array_map(
            static fn (array $column): int => array_sum(array_map(
                static fn (int $x, int $y): int => $x * $y,
                $row,
                $column
            )),
            $columns
        ),
        $left
    );
}

function determinant(array $m): int
{
    return $m[0][0] * ($m[1][1] * $m[2][2] - $m[1][2] * $m[2][1])
         - $m[0][1] * ($m[1][0] * $m[2][2] - $m[1][2] * $m[2][0])
         + $m[0][2] * ($m[1][0] * $m[2][1] - $m[1][1] * $m[2][0]);
}

$product = multiply(LEFT, RIGHT);

foreach ($product as $row) {
    echo implode(' ', $row), "\n";
}
echo determinant($product), "\n";
