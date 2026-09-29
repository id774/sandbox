# fibonacci.exs: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers from a lazily unfolded stream.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     elixir fibonacci.exs
#
# Requirements:
# - Elixir 1.12 or later, on Erlang/OTP 22 or later
# - No third-party package is required

Stream.unfold({0, 1}, fn {current, next} -> {current, {next, current + next}} end)
|> Enum.take(20)
|> Enum.join(" ")
|> IO.puts()
