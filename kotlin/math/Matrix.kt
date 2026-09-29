// Matrix.kt: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices held as arrays of arrays.
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
//     kotlinc Matrix.kt -include-runtime -d matrix.jar && java -jar matrix.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

const val SIZE = 3

val LEFT = arrayOf(intArrayOf(2, -1, 0), intArrayOf(1, 3, 4), intArrayOf(0, 5, -2))
val RIGHT = arrayOf(intArrayOf(1, 0, 2), intArrayOf(-3, 1, 1), intArrayOf(4, 2, 0))

fun multiply(a: Array<IntArray>, b: Array<IntArray>): Array<IntArray> {
    val product = Array(SIZE) { IntArray(SIZE) }
    for (i in 0 until SIZE) {
        for (j in 0 until SIZE) {
            for (k in 0 until SIZE) {
                product[i][j] += a[i][k] * b[k][j]
            }
        }
    }
    return product
}

fun determinant(m: Array<IntArray>): Int =
    m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
        m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
        m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])

fun main() {
    val product = multiply(LEFT, RIGHT)

    for (row in product) {
        println(row.joinToString(" "))
    }
    println(determinant(product))
}
