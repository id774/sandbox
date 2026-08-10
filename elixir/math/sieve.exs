# Print the primes below 100, sieved by rejecting each prime's multiples from the candidates.
# Run: elixir sieve.exs

defmodule Sieve do
  def primes([]), do: []

  def primes([prime | rest]) do
    [prime | primes(Enum.reject(rest, &(rem(&1, prime) == 0)))]
  end
end

2..99
|> Enum.to_list()
|> Sieve.primes()
|> Enum.join(" ")
|> IO.puts()
