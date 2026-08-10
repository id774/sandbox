# Print the primes below 100, sieved over an array of flags indexed by the number itself.
# Run: crystal run sieve.cr

LIMIT = 100

is_prime = Array.new(LIMIT, true)
is_prime[0] = false
is_prime[1] = false

n = 2
while n * n < LIMIT
  if is_prime[n]
    multiple = n * n
    while multiple < LIMIT
      is_prime[multiple] = false
      multiple += n
    end
  end
  n += 1
end

primes = (0...LIMIT).select { |value| is_prime[value] }
puts primes.join(" ")
