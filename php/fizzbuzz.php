<?php
// fizzbuzz.php: FizzBuzz for 1 through 20
//
// Description:
// Print FizzBuzz for 1 through 20.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     php fizzbuzz.php
//
// Requirements:
// - PHP CLI
//

for ($i = 1; $i <= 20; $i++) {
  if ($i % 3 === 0 && $i % 5 === 0) {
    echo 'FizzBuzz' . PHP_EOL;
  } else if ($i % 3 === 0) {
    echo 'Fizz' . PHP_EOL;
  } else if ($i % 5 === 0) {
    echo 'Buzz' . PHP_EOL;
  } else {
    echo $i . PHP_EOL;
  }
}
