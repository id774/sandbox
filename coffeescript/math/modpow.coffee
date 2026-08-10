# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# Run: coffee modpow.coffee

cases = [[2, 1000, 1000003], [3, 200, 50], [5, 117, 19], [10, 18, 9999991]]

modpow = (base, exponent, modulus) ->
  result = 1
  base %= modulus
  while exponent > 0
    result = result * base % modulus if exponent % 2 is 1
    base = base * base % modulus
    exponent = Math.floor(exponent / 2)
  result

for [base, exponent, modulus] in cases
  console.log "#{base} #{exponent} #{modulus} #{modpow(base, exponent, modulus)}"
