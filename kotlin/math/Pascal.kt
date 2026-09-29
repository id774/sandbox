// Pascal.kt: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
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
//     kotlinc Pascal.kt -include-runtime -d pascal.jar && java -jar pascal.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

const val ROWS = 10

fun main() {
    var row = listOf(1L)

    repeat(ROWS) {
        println(row.joinToString(" "))
        row = (listOf(0L) + row).zip(row + listOf(0L)) { left, right -> left + right }
    }
}
