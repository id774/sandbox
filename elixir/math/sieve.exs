# sieve.exs: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved by rejecting each prime's multiples from the candidates.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     elixir sieve.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

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
