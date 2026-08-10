// Print modular powers of fixed triples, each squared and halved by a tail recursion on the exponent.
// Run: scala-cli run ModPow.scala

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
