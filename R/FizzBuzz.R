
n <- 1:100
ans <- n

ans[n%%3==0 -> FizzSet] <- "Fizz"
ans[n%%5==0 -> BuzzSet] <- "Buzz"
 
ans[FizzSet & BuzzSet] <- "FizzBuzz"
 
cat(ans)

