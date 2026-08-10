#!/usr/bin/env ruby
# Print FizzBuzz for 1 through 100, choosing the label by matching the pair of remainders.

def label(n)
  case [n % 3, n % 5]
  in [0, 0] then 'FizzBuzz'
  in [0, _] then 'Fizz'
  in [_, 0] then 'Buzz'
  else n.to_s
  end
end

(1..100).each { |n| puts label(n) }
