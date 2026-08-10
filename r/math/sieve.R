# Print the primes below 100, sieved over a logical vector read back with which.
# Run: Rscript sieve.R

limit <- 100

is_prime <- rep(TRUE, limit)
is_prime[1] <- FALSE

for (n in 2:floor(sqrt(limit))) {
  if (is_prime[n]) {
    is_prime[seq(n * n, limit, by = n)] <- FALSE
  }
}

cat(paste(which(is_prime), collapse = " "), "\n", sep = "")
