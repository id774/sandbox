// GcdLcm.scala: GCD and LCM of fixed pairs by Euclid's algorithm
//
// Description:
// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a tail recursion.
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
//     scala-cli run GcdLcm.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

import scala.annotation.tailrec

val pairs = List((1071L, 462L), (270L, 192L), (17L, 5L), (120L, 36L))

@tailrec
def euclid(first: Long, second: Long): Long =
  if second == 0 then first else euclid(second, first % second)

@main def gcdLcmMain(): Unit =
  pairs.foreach { (first, second) =>
    val divisor = euclid(first, second)
    println(s"$first $second $divisor ${first / divisor * second}")
  }
