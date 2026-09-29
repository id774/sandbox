// matrix.rs: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices held as arrays sized at compile time.
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
// Build / Run:
//     rustc -o matrix matrix.rs
//     ./matrix
//
// Requirements:
// - Rust 1.53 or later (rustc)
// - No third-party package is required

const SIZE: usize = 3;

type Matrix = [[i64; SIZE]; SIZE];

const LEFT: Matrix = [[2, -1, 0], [1, 3, 4], [0, 5, -2]];
const RIGHT: Matrix = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]];

fn multiply(left: &Matrix, right: &Matrix) -> Matrix {
    let mut product = [[0i64; SIZE]; SIZE];

    for (i, row) in product.iter_mut().enumerate() {
        for (j, cell) in row.iter_mut().enumerate() {
            *cell = (0..SIZE).map(|k| left[i][k] * right[k][j]).sum();
        }
    }
    product
}

fn determinant(m: &Matrix) -> i64 {
    m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
        - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
        + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
}

fn main() {
    let product = multiply(&LEFT, &RIGHT);

    for row in &product {
        let fields: Vec<String> = row.iter().map(|value| value.to_string()).collect();
        println!("{}", fields.join(" "));
    }
    println!("{}", determinant(&product));
}
