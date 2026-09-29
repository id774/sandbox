<?php
// quicksort.php: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort over the head and tail of the array.
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
//     php quicksort.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

declare(strict_types=1);

function quicksort(array $items): array
{
    if (count($items) <= 1) {
        return $items;
    }

    $pivot = array_shift($items);
    $smaller = array_filter($items, fn($x) => $x <= $pivot);
    $larger = array_filter($items, fn($x) => $x > $pivot);

    return array_merge(quicksort(array_values($smaller)), [$pivot], quicksort(array_values($larger)));
}

echo implode(' ', quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6])), PHP_EOL;
