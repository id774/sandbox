# Sort a fixed vector with a quicksort over the head and tail of the vector.
# Run: Rscript quicksort.R

quicksort <- function(items) {
  if (length(items) <= 1) {
    return(items)
  }

  pivot <- items[1]
  rest <- items[-1]
  c(quicksort(rest[rest <= pivot]), pivot, quicksort(rest[rest > pivot]))
}

cat(paste(quicksort(c(5, 3, 8, 4, 2, 7, 1, 10, 9, 6)), collapse = " "), "\n", sep = "")
