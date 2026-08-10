# Print FizzBuzz for 1 through 100, with the label picked by a helper function.
# Run: coffee fizzbuzz.coffee

label = (n) ->
  if n % 15 is 0 then 'FizzBuzz'
  else if n % 3 is 0 then 'Fizz'
  else if n % 5 is 0 then 'Buzz'
  else String n

console.log label n for n in [1..100]
