// Print the primes below 100, sieved over a list of flags and gathered by a list comprehension.
// Run: dart run sieve.dart

const limit = 100;

void main() {
  final isPrime = List<bool>.filled(limit, true);
  isPrime[0] = false;
  isPrime[1] = false;

  for (var n = 2; n * n < limit; n++) {
    if (!isPrime[n]) continue;
    for (var multiple = n * n; multiple < limit; multiple += n) {
      isPrime[multiple] = false;
    }
  }

  final primes = [
    for (var n = 0; n < limit; n++)
      if (isPrime[n]) n,
  ];
  print(primes.join(' '));
}
