# Print the start below 1000 with the longest Collatz sequence, picked by which.max over a vector of lengths.
# Run: Rscript collatz.R

limit <- 1000

chain_length <- function(start) {
  value <- start
  count <- 1
  while (value != 1) {
    value <- if (value %% 2 == 0) value %/% 2 else value * 3 + 1
    count <- count + 1
  }
  count
}

starts <- seq_len(limit - 1)
chain_lengths <- vapply(starts, chain_length, numeric(1))
longest <- which.max(chain_lengths)

cat(paste(c(starts[longest], chain_lengths[longest]), collapse = " "), "\n", sep = "")
