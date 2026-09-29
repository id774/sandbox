# quicksort.exs: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort written as two clauses over list patterns.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     elixir quicksort.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

defmodule Quicksort do
  def sort([]), do: []

  def sort([pivot | rest]) do
    smaller = for x <- rest, x <= pivot, do: x
    larger = for x <- rest, x > pivot, do: x
    sort(smaller) ++ [pivot] ++ sort(larger)
  end
end

[5, 3, 8, 4, 2, 7, 1, 10, 9, 6]
|> Quicksort.sort()
|> Enum.join(" ")
|> IO.puts()
