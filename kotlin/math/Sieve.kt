// Print the primes below 100, sieved over a BooleanArray whose index is the number itself.
// Run: kotlinc Sieve.kt -include-runtime -d sieve.jar && java -jar sieve.jar

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
