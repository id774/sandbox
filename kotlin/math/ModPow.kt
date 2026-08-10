// Print modular powers of fixed triples, each squared and shifted down by repeated squaring.
// Run: kotlinc ModPow.kt -include-runtime -d modpow.jar && java -jar modpow.jar

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
