# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# Run: elixir modpow.exs

defmodule ModPow do
  def compute(base, exponent, modulus), do: walk(rem(base, modulus), exponent, modulus, 1)

  defp walk(_base, 0, _modulus, result), do: result

  defp walk(base, exponent, modulus, result) do
    result = if rem(exponent, 2) == 1, do: rem(result * base, modulus), else: result
    walk(rem(base * base, modulus), div(exponent, 2), modulus, result)
  end
end

[{2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}]
|> Enum.each(fn {base, exponent, modulus} ->
  IO.puts("#{base} #{exponent} #{modulus} #{ModPow.compute(base, exponent, modulus)}")
end)
