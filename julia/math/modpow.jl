# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# Run: julia modpow.jl

const CASES = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]

function modpow(base, exponent, modulus)
    result = 1
    base %= modulus
    while exponent > 0
        if isodd(exponent)
            result = result * base % modulus
        end
        base = base * base % modulus
        exponent ÷= 2
    end
    return result
end

for (base, exponent, modulus) in CASES
    println(join((base, exponent, modulus, modpow(base, exponent, modulus)), " "))
end
