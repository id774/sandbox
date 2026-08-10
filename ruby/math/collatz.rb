#!/usr/bin/env ruby
# Print the start below 1000 with the longest Collatz sequence, picked by max_by over a range.

LIMIT = 1000

def chain_length(start)
  value = start
  length = 1
  until value == 1
    value = value.even? ? value / 2 : value * 3 + 1
    length += 1
  end
  length
end

longest = (1...LIMIT).max_by { |start| chain_length(start) }
puts "#{longest} #{chain_length(longest)}"
