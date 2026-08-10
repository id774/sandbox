# Print the first 20 Fibonacci numbers from an Iterator built out of a block.
# Run: crystal run fibonacci.cr

current = 0
following = 1

fibonacci = Iterator.of do
  value = current
  current, following = following, current + following
  value
end

puts fibonacci.first(20).to_a.join(" ")
