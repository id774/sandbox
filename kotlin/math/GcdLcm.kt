// Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a destructured swap.
// Run: kotlinc GcdLcm.kt -include-runtime -d gcd_lcm.jar && java -jar gcd_lcm.jar

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
