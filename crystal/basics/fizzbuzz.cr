# Print FizzBuzz for 1 through 100, choosing the label by matching a tuple of remainders.
# Run: crystal run fizzbuzz.cr

def fizzbuzz_label(n : Int32) : String
  case {n % 3, n % 5}
  when {0, 0} then "FizzBuzz"
  when {0, _} then "Fizz"
  when {_, 0} then "Buzz"
  else             n.to_s
  end
end

(1..100).each { |n| puts fizzbuzz_label(n) }
