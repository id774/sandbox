# Print the first 20 Fibonacci numbers from a lazily unfolded stream.
# Run: elixir fibonacci.exs

Stream.unfold({0, 1}, fn {current, next} -> {current, {next, current + next}} end)
|> Enum.take(20)
|> Enum.join(" ")
|> IO.puts()
