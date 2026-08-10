// Multiply two fixed 3x3 integer matrices, with the matrix shape carried in a type alias.
// Run: tsc --target es2020 matrix.ts && node matrix.js

type Row = [number, number, number];
type Matrix = [Row, Row, Row];

const left: Matrix = [
    [2, -1, 0],
    [1, 3, 4],
    [0, 5, -2],
];
const right: Matrix = [
    [1, 0, 2],
    [-3, 1, 1],
    [4, 2, 0],
];

function multiply(a: Matrix, b: Matrix): Matrix {
    return a.map((row) =>
        b[0].map((_, j) => row.reduce((sum, value, k) => sum + value * b[k][j], 0))
    ) as Matrix;
}

function determinant(m: Matrix): number {
    const [[a, b, c], [d, e, f], [g, h, i]] = m;
    return a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g);
}

const product = multiply(left, right);

for (const row of product) {
    console.log(row.join(" "));
}
console.log(determinant(product));
