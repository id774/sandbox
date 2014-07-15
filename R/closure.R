
func <- function() {
  x <- 0
  function() {
    x <<- x + 1
    return (x)
  }
}

x <- 10

closure <- func()

print(x)
print(closure())
print(closure())
print(closure())
print(closure())
print(x)

