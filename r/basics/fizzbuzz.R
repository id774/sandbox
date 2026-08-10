# Print FizzBuzz for 1 through 100, choosing the label from the remainders.
# Run: Rscript fizzbuzz.R

label <- function(n) {
  if (n %% 15 == 0) {
    "FizzBuzz"
  } else if (n %% 3 == 0) {
    "Fizz"
  } else if (n %% 5 == 0) {
    "Buzz"
  } else {
    as.character(n)
  }
}

for (n in 1:100) {
  cat(label(n), "\n", sep = "")
}
