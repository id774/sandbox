// Sieve.scala: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over an array of flags indexed by the number itself.
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
//     scala-cli run Sieve.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

@main def sieveMain(): Unit =
  val limit = 100
  val isPrime = Array.fill(limit)(true)
  isPrime(0) = false
  isPrime(1) = false

  var n = 2
  while n * n < limit do
    if isPrime(n) then
      var multiple = n * n
      while multiple < limit do
        isPrime(multiple) = false
        multiple += n
    n += 1

  println((0 until limit).filter(n => isPrime(n)).mkString(" "))
