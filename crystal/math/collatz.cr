# Print the start below 1000 with the longest Collatz sequence, picked by max_by over a range.
# Run: crystal run collatz.cr

LIMIT = 1000

def chain_length(start : Int32) : Int32
  value = start
  length = 1
  while value != 1
    value = value.even? ? value // 2 : value * 3 + 1
    length += 1
  end
  length
end

longest = (1...LIMIT).max_by { |start| chain_length(start) }
puts "#{longest} #{chain_length(longest)}"
