// Fibonacci.kt: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a lazily generated sequence.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     kotlinc Fibonacci.kt -include-runtime -d fibonacci.jar && java -jar fibonacci.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

fun fibonacci(): Sequence<Long> =
    generateSequence(0L to 1L) { (current, next) -> next to (current + next) }
        .map { (current, _) -> current }

fun main() {
    println(fibonacci().take(20).joinToString(" "))
}
