// FizzBuzz.kt: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, choosing the label with a when expression.
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
//     kotlinc FizzBuzz.kt -include-runtime -d fizzbuzz.jar && java -jar fizzbuzz.jar
//
// Requirements:
// - Kotlin 1.4 or later (kotlinc)
// - JDK 8 or later, for kotlinc and java -jar
// - No third-party package is required

fun fizzBuzzLabel(n: Int): String = when {
    n % 15 == 0 -> "FizzBuzz"
    n % 3 == 0 -> "Fizz"
    n % 5 == 0 -> "Buzz"
    else -> n.toString()
}

fun main() {
    for (n in 1..100) {
        println(fizzBuzzLabel(n))
    }
}
