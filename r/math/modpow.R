# Print modular powers of fixed triples, each squared and halved by repeated squaring.
# The products are parenthesised because %% and %/% bind tighter than * in R.
# Run: Rscript modpow.R

cases <- list(c(2, 1000, 1000003), c(3, 200, 50), c(5, 117, 19), c(10, 18, 9999991))

modpow <- function(base, exponent, modulus) {
  result <- 1
  base <- base %% modulus
  while (exponent > 0) {
    if (exponent %% 2 == 1) {
      result <- (result * base) %% modulus
    }
    base <- (base * base) %% modulus
    exponent <- exponent %/% 2
  }
  result
}

for (case in cases) {
  base <- case[1]
  exponent <- case[2]
  modulus <- case[3]
  cat(paste(c(base, exponent, modulus, modpow(base, exponent, modulus)), collapse = " "), "\n", sep = "")
}
