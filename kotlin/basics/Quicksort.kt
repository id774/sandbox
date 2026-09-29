// Quicksort.kt: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed list with a quicksort generic over any Comparable element.
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
//     kotlinc Quicksort.kt -include-runtime -d quicksort.jar && java -jar quicksort.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

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
