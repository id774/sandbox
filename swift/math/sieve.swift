// Print the primes below 100, sieved over an array of flags indexed by the number itself.
// Run: swift sieve.swift

let limit = 100

var isPrime = [Bool](repeating: true, count: limit)
isPrime[0] = false
isPrime[1] = false

var n = 2
while n * n < limit {
    if isPrime[n] {
        var multiple = n * n
        while multiple < limit {
            isPrime[multiple] = false
            multiple += n
        }
    }
    n += 1
}

print((0..<limit).filter { isPrime[$0] }.map(String.init).joined(separator: " "))
