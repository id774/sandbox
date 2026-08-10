// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Run: tsc --target es2020 collatz.ts && node collatz.js

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
