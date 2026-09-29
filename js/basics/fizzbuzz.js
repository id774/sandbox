// fizzbuzz.js: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, with the label picked by a helper function.
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
//     node fizzbuzz.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required

function fizzbuzzLabel(n) {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}

for (let n = 1; n <= 100; n += 1) {
  console.log(fizzbuzzLabel(n));
}
