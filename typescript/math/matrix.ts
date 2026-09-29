// matrix.ts: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices, with the matrix shape carried in a type alias.
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
//     tsc --target es2020 matrix.ts && node matrix.js
//
// Requirements:
// - TypeScript 5.0 or later (tsc)
// - Node.js 20 or later
// - No third-party package is required

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
