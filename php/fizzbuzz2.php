<?php
// fizzbuzz2.php: FizzBuzz with evaluation separated from output
//
// Description:
// Print FizzBuzz for 1 through 20, separating evaluation from output.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     php fizzbuzz2.php
//
// Requirements:
// - PHP CLI
//

function evaluate($i) {
    if ($i % 3 === 0 && $i % 5 === 0) {
        return 'FizzBuzz';
    } else if ($i % 3 === 0) {
        return 'Fizz';
    } else if ($i % 5 === 0) {
        return 'Buzz';
    } else {
        return $i;
    }
}

function render($output) {
    echo $output . PHP_EOL;
}

for ($i = 1; $i <= 20; $i++) {
    $output = evaluate($i);
    render($output);
}
