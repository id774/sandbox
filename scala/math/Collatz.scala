// Collatz.scala: Longest Collatz sequence for a start below 1000
//
// Description:
// Print the start below 1000 with the longest Collatz sequence, picked by maxBy over a range.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     scala-cli run Collatz.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

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
