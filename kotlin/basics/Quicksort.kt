// Sort a fixed list with a quicksort generic over any Comparable element.
// Run: kotlinc Quicksort.kt -include-runtime -d quicksort.jar && java -jar quicksort.jar

fun <T : Comparable<T>> quicksort(items: List<T>): List<T> {
    if (items.size <= 1) return items
    val pivot = items.first()
    val rest = items.drop(1)
    return quicksort(rest.filter { it <= pivot }) + pivot + quicksort(rest.filter { it > pivot })
}

fun main() {
    val numbers = listOf(5, 3, 8, 4, 2, 7, 1, 10, 9, 6)
    println(quicksort(numbers).joinToString(" "))
}
