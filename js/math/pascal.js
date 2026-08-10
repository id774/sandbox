// Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
// Run: node pascal.js

const ROWS = 10;

let row = [1];

for (let i = 0; i < ROWS; i++) {
  console.log(row.join(" "));
  const shifted = [0, ...row];
  const padded = [...row, 0];
  row = shifted.map((value, index) => value + padded[index]);
}
