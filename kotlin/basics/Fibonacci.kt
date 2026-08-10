// Print the first 20 Fibonacci numbers from a lazily generated sequence.
// Run: kotlinc Fibonacci.kt -include-runtime -d fibonacci.jar && java -jar fibonacci.jar

fun fibonacci(): Sequence<Long> =
    generateSequence(0L to 1L) { (current, next) -> next to (current + next) }
        .map { (current, _) -> current }

fun main() {
    println(fibonacci().take(20).joinToString(" "))
}
