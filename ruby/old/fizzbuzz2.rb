# Print FizzBuzz for 1 through 100 with a nested conditional.

def fizzbuzz(n)
    n % 15 == 0 ? 'FizzBuzz' : n % 5 == 0 ? 'Buzz' : n % 3 == 0 ? 'Fizz' : n.to_s
end

1.upto(100) do |i|
    puts fizzbuzz(i)
end

