# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# The values are Int64 because the squares outgrow the Int32 that a literal would give.
# Run: crystal run modpow.cr

CASES = [
  {2_i64, 1000_i64, 1000003_i64},
  {3_i64, 200_i64, 50_i64},
  {5_i64, 117_i64, 19_i64},
  {10_i64, 18_i64, 9999991_i64},
]

def modpow(base : Int64, exponent : Int64, modulus : Int64) : Int64
  result = 1_i64
  base %= modulus
  while exponent > 0
    result = result * base % modulus if exponent.odd?
    base = base * base % modulus
    exponent //= 2
  end
  result
end

CASES.each do |(base, exponent, modulus)|
  puts "#{base} #{exponent} #{modulus} #{modpow(base, exponent, modulus)}"
end
