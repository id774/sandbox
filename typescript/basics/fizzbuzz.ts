// fizzbuzz.ts: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, with the label picked by a typed helper function.
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
//     tsc --target es2020 fizzbuzz.ts && node fizzbuzz.js
//
// Requirements:
// - TypeScript compiler (tsc)
// - Node.js runtime
// - No third-party package is required
//
// Verified Environment:
// Tested with TypeScript 6.0.2 and Node.js 22.23.5.

function fizzbuzzLabel(n: number): string {
    if (n % 15 === 0) return "FizzBuzz";
    if (n % 3 === 0) return "Fizz";
    if (n % 5 === 0) return "Buzz";
    return String(n);
}

for (let n = 1; n <= 100; n++) {
    console.log(fizzbuzzLabel(n));
}
