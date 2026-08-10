# Print the first 20 Fibonacci numbers, collected into an array.
# Run: coffee fibonacci.coffee

fibonacci = (count) ->
  values = []
  [current, following] = [0, 1]
  for _ in [1..count]
    values.push current
    [current, following] = [following, current + following]
  values

console.log fibonacci(20).join ' '
