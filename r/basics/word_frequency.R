# word_frequency.R: Word frequencies of a fixed sentence
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
#     Rscript word_frequency.R
#
# Requirements:
# - R 4.0 or later (Rscript)
# - No third-party package is required

text <- "the quick brown fox jumps over the lazy dog the fox barks"

words <- strsplit(text, "\\s+")[[1]]
counts <- table(words)
ranked <- counts[order(-as.integer(counts), names(counts))]

for (word in names(ranked)) {
  cat(word, " ", ranked[[word]], "\n", sep = "")
}
