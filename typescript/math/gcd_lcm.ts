// Print the divisor and multiple of fixed pairs, with the pairs typed as a tuple array.
// Run: tsc --target es2020 gcd_lcm.ts && node gcd_lcm.js

const pairs: [number, number][] = [
    [1071, 462],
    [270, 192],
    [17, 5],
    [120, 36],
];

function gcd(first: number, second: number): number {
    while (second !== 0) {
        [first, second] = [second, first % second];
    }
    return first;
}

for (const [first, second] of pairs) {
    const divisor = gcd(first, second);
    console.log(`${first} ${second} ${divisor} ${(first / divisor) * second}`);
}
