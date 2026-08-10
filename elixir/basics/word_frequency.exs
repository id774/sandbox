# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: elixir word_frequency.exs

text = "the quick brown fox jumps over the lazy dog the fox barks"

text
|> String.split(~r/\s+/, trim: true)
|> Enum.frequencies()
|> Enum.sort_by(fn {word, count} -> {-count, word} end)
|> Enum.each(fn {word, count} -> IO.puts("#{word} #{count}") end)
