<?php
// Sort a fixed array with a quicksort over the head and tail of the array.

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
