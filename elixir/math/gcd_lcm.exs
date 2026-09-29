# gcd_lcm.exs: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as two clauses.
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
#     elixir gcd_lcm.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

defmodule GcdLcm do
  def euclid(first, 0), do: first
  def euclid(first, second), do: euclid(second, rem(first, second))
end

[{1071, 462}, {270, 192}, {17, 5}, {120, 36}]
|> Enum.each(fn {first, second} ->
  divisor = GcdLcm.euclid(first, second)
  IO.puts("#{first} #{second} #{divisor} #{div(first, divisor) * second}")
end)
