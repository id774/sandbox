// ModPow.scala: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and halved by a tail recursion on the exponent.
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
//     scala-cli run ModPow.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

import scala.annotation.tailrec

val cases = List((2L, 1000L, 1000003L), (3L, 200L, 50L), (5L, 117L, 19L), (10L, 18L, 9999991L))

def modpow(base: Long, exponent: Long, modulus: Long): Long =
  @tailrec
  def walk(factor: Long, power: Long, result: Long): Long =
    if power == 0 then result
    else
      val carried = if power % 2 == 1 then result * factor % modulus else result
      walk(factor * factor % modulus, power / 2, carried)

  walk(base % modulus, exponent, 1L)

@main def modPowMain(): Unit =
  cases.foreach { (base, exponent, modulus) =>
    println(s"$base $exponent $modulus ${modpow(base, exponent, modulus)}")
  }
