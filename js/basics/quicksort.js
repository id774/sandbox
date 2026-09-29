// quicksort.js: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort over the destructured head and tail.
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
//     node quicksort.js
//
// Requirements:
// - Node.js 20 or later
// - No third-party package is required

function quicksort(items) {
  if (items.length <= 1) return [...items];

  const [pivot, ...rest] = items;
  const smaller = rest.filter((x) => x <= pivot);
  const larger = rest.filter((x) => x > pivot);
  return [...quicksort(smaller), pivot, ...quicksort(larger)];
}

console.log(quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join(" "));
