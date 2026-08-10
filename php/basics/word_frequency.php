<?php
// Count the words of a fixed text, most frequent first and alphabetically within a tie.

declare(strict_types=1);

$text = 'the quick brown fox jumps over the lazy dog the fox barks';

$counts = array_count_values(preg_split('/\s+/', $text, -1, PREG_SPLIT_NO_EMPTY));
uksort($counts, fn($a, $b) => [$counts[$b], $a] <=> [$counts[$a], $b]);

foreach ($counts as $word => $count) {
    echo $word, ' ', $count, PHP_EOL;
}
