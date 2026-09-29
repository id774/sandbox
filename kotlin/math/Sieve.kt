// Sieve.kt: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a BooleanArray whose index is the number itself.
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
//     kotlinc Sieve.kt -include-runtime -d sieve.jar && java -jar sieve.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

fun main() {
    val limit = 100
    val isPrime = BooleanArray(limit) { it >= 2 }

    var n = 2
    while (n * n < limit) {
        if (isPrime[n]) {
            var multiple = n * n
            while (multiple < limit) {
                isPrime[multiple] = false
                multiple += n
            }
        }
        n++
    }

    println((0 until limit).filter { isPrime[it] }.joinToString(" "))
}
