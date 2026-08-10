// Print the primes below 100, sieved over an array of flags indexed by the number itself.
// Run: scala-cli run Sieve.scala

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
