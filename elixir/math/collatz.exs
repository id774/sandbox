# Print the start below 1000 with the longest Collatz sequence, picked by max_by over a range.
# Run: elixir collatz.exs

defmodule Collatz do
  def chain_length(1), do: 1
  def chain_length(n) when rem(n, 2) == 0, do: 1 + chain_length(div(n, 2))
  def chain_length(n), do: 1 + chain_length(n * 3 + 1)
end

longest = Enum.max_by(1..999, &Collatz.chain_length/1)
IO.puts("#{longest} #{Collatz.chain_length(longest)}")
