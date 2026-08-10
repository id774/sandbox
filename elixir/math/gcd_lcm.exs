# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as two clauses.
# Run: elixir gcd_lcm.exs

defmodule GcdLcm do
  def euclid(first, 0), do: first
  def euclid(first, second), do: euclid(second, rem(first, second))
end

[{1071, 462}, {270, 192}, {17, 5}, {120, 36}]
|> Enum.each(fn {first, second} ->
  divisor = GcdLcm.euclid(first, second)
  IO.puts("#{first} #{second} #{divisor} #{div(first, divisor) * second}")
end)
