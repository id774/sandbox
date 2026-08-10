// Multiply two fixed 3x3 integer matrices, with each entry folded by reduce over the shared index.
// Run: node matrix.js

const left = [
  [2, -1, 0],
  [1, 3, 4],
  [0, 5, -2],
];
const right = [
  [1, 0, 2],
  [-3, 1, 1],
  [4, 2, 0],
];

function multiply(a, b) {
  return a.map((row) =>
    b[0].map((_, j) => row.reduce((sum, value, k) => sum + value * b[k][j], 0))
  );
}

function determinant([[a, b, c], [d, e, f], [g, h, i]]) {
  return a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g);
}

const product = multiply(left, right);

for (const row of product) {
  console.log(row.join(" "));
}
console.log(determinant(product));
