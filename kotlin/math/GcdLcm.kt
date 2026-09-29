// GcdLcm.kt: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a destructured swap.
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
//     kotlinc GcdLcm.kt -include-runtime -d gcd_lcm.jar && java -jar gcd_lcm.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

val PAIRS = listOf(1071L to 462L, 270L to 192L, 17L to 5L, 120L to 36L)

fun euclid(first: Long, second: Long): Long {
    var a = first
    var b = second
    while (b != 0L) {
        val remainder = a % b
        a = b
        b = remainder
    }
    return a
}

fun main() {
    for ((first, second) in PAIRS) {
        val divisor = euclid(first, second)
        println("$first $second $divisor ${first / divisor * second}")
    }
}
