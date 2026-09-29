# collatz.exs: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, picked by max_by over a range.
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
#     elixir collatz.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

defmodule Collatz do
  def chain_length(1), do: 1
  def chain_length(n) when rem(n, 2) == 0, do: 1 + chain_length(div(n, 2))
  def chain_length(n), do: 1 + chain_length(n * 3 + 1)
end

longest = Enum.max_by(1..999, &Collatz.chain_length/1)
IO.puts("#{longest} #{Collatz.chain_length(longest)}")
