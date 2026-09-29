# word_frequency.jl: Word frequencies of a fixed sentence
#
# Description:
# Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
#     julia word_frequency.jl
#
# Requirements:
# - Julia 1.4 or later
# - No third-party package is required

const TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

counts = Dict{String,Int}()
for word in split(TEXT)
    counts[word] = get(counts, word, 0) + 1
end

for (word, count) in sort(collect(counts), by = pair -> (-pair.second, pair.first))
    println("$word $count")
end
