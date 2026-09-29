// Fibonacci.scala: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a lazily unfolded LazyList.
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
//     scala-cli run Fibonacci.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

val fibonacci: LazyList[BigInt] =
  LazyList.unfold((BigInt(0), BigInt(1))) { case (current, next) =>
    Some((current, (next, current + next)))
  }

@main def fibonacciMain(): Unit =
  println(fibonacci.take(20).mkString(" "))
