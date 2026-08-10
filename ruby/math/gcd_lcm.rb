#!/usr/bin/env ruby
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from Integer.

PAIRS = [[1071, 462], [270, 192], [17, 5], [120, 36]].freeze

def gcd(first, second)
  first, second = second, first % second until second.zero?
  first
end

PAIRS.each do |first, second|
  divisor = gcd(first, second)
  puts "#{first} #{second} #{divisor} #{first / divisor * second}"
end
