# Count the words of a fixed text, most frequent first and alphabetically within a tie.
# Run: Rscript word_frequency.R

text <- "the quick brown fox jumps over the lazy dog the fox barks"

words <- strsplit(text, "\\s+")[[1]]
counts <- table(words)
ranked <- counts[order(-as.integer(counts), names(counts))]

for (word in names(ranked)) {
  cat(word, " ", ranked[[word]], "\n", sep = "")
}
