// Print FizzBuzz for 1 through 100, choosing the label by matching the pair of remainders.
// Run: scala-cli run FizzBuzz.scala

def label(n: Int): String = (n % 3, n % 5) match
  case (0, 0) => "FizzBuzz"
  case (0, _) => "Fizz"
  case (_, 0) => "Buzz"
  case _      => n.toString

@main def fizzBuzz(): Unit =
  for n <- 1 to 100 do println(label(n))
