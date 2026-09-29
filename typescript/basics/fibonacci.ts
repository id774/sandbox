// fibonacci.ts: The first 20 Fibonacci numbers
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
//     tsc --target es2020 fibonacci.ts && node fibonacci.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

function* fibonacci(): Generator<number> {
    let [current, next] = [0, 1];
    while (true) {
        yield current;
        [current, next] = [next, current + next];
    }
}

function take<T>(source: Iterable<T>, count: number): T[] {
    const values: T[] = [];
    for (const value of source) {
        values.push(value);
        if (values.length === count) break;
    }
    return values;
}

console.log(take(fibonacci(), 20).join(" "));
