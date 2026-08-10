# Sort a fixed list with a quicksort written as two clauses over list patterns.
# Run: elixir quicksort.exs

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
