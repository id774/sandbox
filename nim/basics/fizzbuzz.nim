# Print FizzBuzz for 1 through 100, with the label returned by an if expression.
# Run: nim c -r fizzbuzz.nim

proc fizzBuzzLabel(n: int): string =
  if n mod 15 == 0: "FizzBuzz"
  elif n mod 3 == 0: "Fizz"
  elif n mod 5 == 0: "Buzz"
  else: $n

for n in 1 .. 100:
  echo fizzBuzzLabel(n)
