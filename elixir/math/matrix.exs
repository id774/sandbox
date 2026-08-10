# Multiply two fixed 3x3 integer matrices, reaching the right one's columns with zip.
# Run: elixir matrix.exs

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
