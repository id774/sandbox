// FizzBuzz.scala: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, choosing the label by matching the pair of remainders.
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
//     scala-cli run FizzBuzz.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

def label(n: Int): String = (n % 3, n % 5) match
  case (0, 0) => "FizzBuzz"
  case (0, _) => "Fizz"
  case (_, 0) => "Buzz"
  case _      => n.toString

@main def fizzBuzz(): Unit =
  for n <- 1 to 100 do println(label(n))
