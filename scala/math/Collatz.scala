// Print the start below 1000 with the longest Collatz sequence, picked by maxBy over a range.
// Run: scala-cli run Collatz.scala

def chainLength(start: Long): Int =
  var value = start
  var length = 1
  while value != 1 do
    value = if value % 2 == 0 then value / 2 else value * 3 + 1
    length += 1
  length

@main def collatzMain(): Unit =
  val longest = (1 until 1000).maxBy(start => chainLength(start))
  println(s"$longest ${chainLength(longest)}")
