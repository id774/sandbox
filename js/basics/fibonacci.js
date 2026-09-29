// fibonacci.js: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a generator function.
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
//     node fibonacci.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required

function* fibonacci() {
  let current = 0;
  let following = 1;
  while (true) {
    yield current;
    [current, following] = [following, current + following];
  }
}

function take(source, count) {
  const values = [];
  for (const value of source) {
    values.push(value);
    if (values.length === count) break;
  }
  return values;
}

console.log(take(fibonacci(), 20).join(" "));
