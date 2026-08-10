// Print modular powers of fixed triples, each squared and halved by repeated squaring.
// Run: dart run modpow.dart

const cases = [
  [2, 1000, 1000003],
  [3, 200, 50],
  [5, 117, 19],
  [10, 18, 9999991],
];

int modpow(int base, int exponent, int modulus) {
  var result = 1;
  base %= modulus;

  while (exponent > 0) {
    if (exponent.isOdd) result = result * base % modulus;
    base = base * base % modulus;
    exponent ~/= 2;
  }
  return result;
}

void main() {
  for (final triple in cases) {
    final base = triple[0];
    final exponent = triple[1];
    final modulus = triple[2];
    print('$base $exponent $modulus ${modpow(base, exponent, modulus)}');
  }
}
