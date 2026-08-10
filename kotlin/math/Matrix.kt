// Multiply two fixed 3x3 integer matrices held as arrays of arrays.
// Run: kotlinc Matrix.kt -include-runtime -d matrix.jar && java -jar matrix.jar

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
