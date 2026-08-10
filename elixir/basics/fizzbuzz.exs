# Print FizzBuzz for 1 through 100, choosing the label by matching a tuple of remainders.
# Run: elixir fizzbuzz.exs

defmodule FizzBuzz do
  def label(n) do
    case {rem(n, 3), rem(n, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _ -> Integer.to_string(n)
    end
  end
end

Enum.each(1..100, fn n -> IO.puts(FizzBuzz.label(n)) end)
