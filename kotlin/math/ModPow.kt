// ModPow.kt: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and shifted down by repeated squaring.
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
//     kotlinc ModPow.kt -include-runtime -d modpow.jar && java -jar modpow.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

val CASES = listOf(
    Triple(2L, 1000L, 1000003L),
    Triple(3L, 200L, 50L),
    Triple(5L, 117L, 19L),
    Triple(10L, 18L, 9999991L),
)

fun modpow(base: Long, exponent: Long, modulus: Long): Long {
    var factor = base % modulus
    var power = exponent
    var result = 1L

    while (power > 0) {
        if ((power and 1L) == 1L) {
            result = result * factor % modulus
        }
        factor = factor * factor % modulus
        power = power shr 1
    }
    return result
}

fun main() {
    for ((base, exponent, modulus) in CASES) {
        println("$base $exponent $modulus ${modpow(base, exponent, modulus)}")
    }
}
