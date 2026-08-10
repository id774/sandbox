# Print the primes below 100, sieved over a sequence of flags indexed by the number itself.
# Run: nim c -r sieve.nim

import std/[sequtils, strutils]

const Limit = 100

var isPrime = newSeq[bool](Limit)
for value in 2 ..< Limit:
  isPrime[value] = true

var n = 2
while n * n < Limit:
  if isPrime[n]:
    var multiple = n * n
    while multiple < Limit:
      isPrime[multiple] = false
      multiple += n
  inc n

echo toSeq(0 ..< Limit).filterIt(isPrime[it]).mapIt($it).join(" ")
