# matrix.exs: Product and determinant of two fixed 3x3 integer matrices
#
# Description:
# Multiply two fixed 3x3 integer matrices, reaching the right one's columns with zip.
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
#     elixir matrix.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

defmodule Matrix do
  def multiply(left, right) do
    columns = right |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

    for row <- left do
      for column <- columns do
        row |> Enum.zip(column) |> Enum.map(fn {x, y} -> x * y end) |> Enum.sum()
      end
    end
  end

  def determinant([[a, b, c], [d, e, f], [g, h, i]]) do
    a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)
  end
end

left = [[2, -1, 0], [1, 3, 4], [0, 5, -2]]
right = [[1, 0, 2], [-3, 1, 1], [4, 2, 0]]
product = Matrix.multiply(left, right)

Enum.each(product, fn row -> IO.puts(Enum.join(row, " ")) end)
IO.puts(Matrix.determinant(product))
