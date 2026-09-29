// quicksort.ts: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed array with a quicksort taking the comparison as a callback.
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
//     tsc --target es2020 quicksort.ts && node quicksort.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

function quicksort<T>(items: readonly T[], compare: (a: T, b: T) => number): T[] {
    if (items.length <= 1) return [...items];
    const [pivot, ...rest] = items;
    const smaller = rest.filter((x) => compare(x, pivot) <= 0);
    const larger = rest.filter((x) => compare(x, pivot) > 0);
    return [...quicksort(smaller, compare), pivot, ...quicksort(larger, compare)];
}

const unsorted = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
console.log(quicksort(unsorted, (a, b) => a - b).join(" "));
