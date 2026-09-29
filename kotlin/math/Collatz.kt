// Collatz.kt: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, picked by maxByOrNull over a range.
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
//     kotlinc Collatz.kt -include-runtime -d collatz.jar && java -jar collatz.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

fun chainLength(start: Int): Int {
    var value = start.toLong()
    var length = 1
    while (value != 1L) {
        value = if (value % 2 == 0L) value / 2 else value * 3 + 1
        length++
    }
    return length
}

fun main() {
    val limit = 1000
    val longest = (1 until limit).maxByOrNull { chainLength(it) }!!
    println("$longest ${chainLength(longest)}")
}
