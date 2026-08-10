// Print FizzBuzz for 1 through 100, choosing the label with a when expression.
// Run: kotlinc FizzBuzz.kt -include-runtime -d fizzbuzz.jar && java -jar fizzbuzz.jar

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
