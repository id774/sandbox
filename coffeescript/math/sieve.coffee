# Print the primes below 100, sieved over an array of flags built by a comprehension.
# Run: coffee sieve.coffee

limit = 100

isPrime = (n >= 2 for n in [0...limit])

n = 2
while n * n < limit
  if isPrime[n]
    multiple = n * n
    while multiple < limit
      isPrime[multiple] = false
      multiple += n
  n++

primes = (n for n in [0...limit] when isPrime[n])
console.log primes.join ' '
