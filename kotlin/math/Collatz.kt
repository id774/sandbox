// Print the start below 1000 with the longest Collatz sequence, picked by maxByOrNull over a range.
// Run: kotlinc Collatz.kt -include-runtime -d collatz.jar && java -jar collatz.jar

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
