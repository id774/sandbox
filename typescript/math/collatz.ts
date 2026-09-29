// collatz.ts: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     tsc --target es2020 collatz.ts && node collatz.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

const limit = 1000;

function chainLength(start: number): number {
    let value = start;
    let length = 1;
    while (value !== 1) {
        value = value % 2 === 0 ? value / 2 : value * 3 + 1;
        length++;
    }
    return length;
}

let longest = 1;
let best = 1;

for (let start = 1; start < limit; start++) {
    const length = chainLength(start);
    if (length > best) {
        longest = start;
        best = length;
    }
}

console.log(`${longest} ${best}`);
