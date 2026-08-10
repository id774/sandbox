// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: kotlinc WordFrequency.kt -include-runtime -d word_frequency.jar && java -jar word_frequency.jar

const val TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

fun main() {
    TEXT.split(Regex("\\s+"))
        .groupingBy { it }
        .eachCount()
        .entries
        .sortedWith(compareByDescending<Map.Entry<String, Int>> { it.value }.thenBy { it.key })
        .forEach { (word, count) -> println("$word $count") }
}
