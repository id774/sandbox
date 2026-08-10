# Print FizzBuzz for 1 through 100, choosing the label from the remainders.
# Run: julia fizzbuzz.jl

function fizzbuzz_label(n::Integer)
    if n % 15 == 0
        "FizzBuzz"
    elseif n % 3 == 0
        "Fizz"
    elseif n % 5 == 0
        "Buzz"
    else
        string(n)
    end
end

for n in 1:100
    println(fizzbuzz_label(n))
end
