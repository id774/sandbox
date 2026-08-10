# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written out rather than taken from Int.
# Run: crystal run gcd_lcm.cr

PAIRS = [{1071, 462}, {270, 192}, {17, 5}, {120, 36}]

def euclid(first : Int32, second : Int32) : Int32
  while second != 0
    first, second = second, first % second
  end
  first
end

PAIRS.each do |(first, second)|
  divisor = euclid(first, second)
  puts "#{first} #{second} #{divisor} #{first // divisor * second}"
end
