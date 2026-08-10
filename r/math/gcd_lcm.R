# Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
# Run: Rscript gcd_lcm.R

pairs <- list(c(1071, 462), c(270, 192), c(17, 5), c(120, 36))

euclid <- function(first, second) {
  while (second != 0) {
    remainder <- first %% second
    first <- second
    second <- remainder
  }
  first
}

for (pair in pairs) {
  first <- pair[1]
  second <- pair[2]
  divisor <- euclid(first, second)
  cat(paste(c(first, second, divisor, (first %/% divisor) * second), collapse = " "), "\n", sep = "")
}
