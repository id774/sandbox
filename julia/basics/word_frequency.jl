# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: julia word_frequency.jl

const TEXT = "the quick brown fox jumps over the lazy dog the fox barks"

counts = Dict{String,Int}()
for word in split(TEXT)
    counts[word] = get(counts, word, 0) + 1
end

for (word, count) in sort(collect(counts), by = pair -> (-pair.second, pair.first))
    println("$word $count")
end
