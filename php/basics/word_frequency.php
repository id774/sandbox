<?php
// word_frequency.php: Word frequencies of a fixed sentence
//
// Description:
// Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
//     php word_frequency.php
//
// Requirements:
// - PHP 8.0 or later (CLI)
// - No third-party package is required

declare(strict_types=1);

$text = 'the quick brown fox jumps over the lazy dog the fox barks';

$counts = array_count_values(preg_split('/\s+/', $text, -1, PREG_SPLIT_NO_EMPTY));
uksort($counts, fn($a, $b) => [$counts[$b], $a] <=> [$counts[$a], $b]);

foreach ($counts as $word => $count) {
    echo $word, ' ', $count, PHP_EOL;
}
