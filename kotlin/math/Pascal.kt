// Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
// Run: kotlinc Pascal.kt -include-runtime -d pascal.jar && java -jar pascal.jar

const val ROWS = 10

fun main() {
    var row = listOf(1L)

    repeat(ROWS) {
        println(row.joinToString(" "))
        row = (listOf(0L) + row).zip(row + listOf(0L)) { left, right -> left + right }
    }
}
