// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a tail recursion.
// Run: scala-cli run GcdLcm.scala

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
