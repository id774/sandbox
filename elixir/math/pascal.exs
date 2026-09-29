# pascal.exs: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, taken from the stream each row of which zips the one before.
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
#     elixir pascal.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

next = fn row -> Enum.zip_with([0 | row], row ++ [0], &+/2) end

[1]
|> Stream.iterate(next)
|> Enum.take(10)
|> Enum.each(fn row -> IO.puts(Enum.join(row, " ")) end)
