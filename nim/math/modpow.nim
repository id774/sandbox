# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# Run: nim c -r modpow.nim

const Cases = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

proc modpow(base, exponent, modulus: int): int =
  var
    factor = base mod modulus
    power = exponent
  result = 1
  while power > 0:
    if power mod 2 == 1:
      result = result * factor mod modulus
    factor = factor * factor mod modulus
    power = power div 2

for (base, exponent, modulus) in Cases:
  echo base, " ", exponent, " ", modulus, " ", modpow(base, exponent, modulus)
