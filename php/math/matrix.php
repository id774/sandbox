<?php
// matrix.php: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices, with the inner product folded by array_sum over array_map.
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
//     php matrix.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

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
