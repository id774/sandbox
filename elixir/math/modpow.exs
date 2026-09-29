# modpow.exs: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
#     elixir modpow.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

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
