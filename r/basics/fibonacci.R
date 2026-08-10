# Print the first 20 Fibonacci numbers, filled into a preallocated vector.
# Run: Rscript fibonacci.R

fibonacci <- function(count) {
  values <- integer(count)
  current <- 0L
  following <- 1L
  for (i in seq_len(count)) {
    values[i] <- current
    step <- current + following
    current <- following
    following <- step
  }
  values
}

cat(paste(fibonacci(20), collapse = " "), "\n", sep = "")
