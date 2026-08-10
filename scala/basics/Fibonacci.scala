// Print the first 20 Fibonacci numbers from a lazily unfolded LazyList.
// Run: scala-cli run Fibonacci.scala

val fibonacci: LazyList[BigInt] =
  LazyList.unfold((BigInt(0), BigInt(1))) { case (current, next) =>
    Some((current, (next, current + next)))
  }

@main def fibonacciMain(): Unit =
  println(fibonacci.take(20).mkString(" "))
