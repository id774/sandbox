# sieve.nim: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved over a sequence of flags indexed by the number itself.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nim c -r sieve.nim
#
# Requirements:
# - Nim 1.6 or later, with a C compiler for its default C backend
# - No third-party package is required

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
