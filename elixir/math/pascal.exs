# Print 10 rows of Pascal's triangle, taken from the stream each row of which zips the one before.
# Run: elixir pascal.exs

next = fn row -> Enum.zip_with([0 | row], row ++ [0], &+/2) end

[1]
|> Stream.iterate(next)
|> Enum.take(10)
|> Enum.each(fn row -> IO.puts(Enum.join(row, " ")) end)
