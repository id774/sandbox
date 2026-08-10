# Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
# Run: Rscript pascal.R

rows <- 10

row <- 1
for (i in seq_len(rows)) {
  cat(paste(row, collapse = " "), "\n", sep = "")
  row <- c(0, row) + c(row, 0)
}
