#!/usr/bin/env ruby
# Print the first 20 Fibonacci numbers from a lazy Enumerator.

fibonacci = Enumerator.new do |yielder|
  current = 0
  following = 1
  loop do
    yielder << current
    current, following = following, current + following
  end
end

puts fibonacci.take(20).join(' ')
