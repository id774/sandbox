// Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
// Run: tsc --target es2020 pascal.ts && node pascal.js

const rows = 10;

let row: number[] = [1];

for (let i = 0; i < rows; i++) {
    console.log(row.join(" "));
    const shifted = [0, ...row];
    const padded = [...row, 0];
    row = shifted.map((value, index) => value + padded[index]);
}
