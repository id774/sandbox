// Print FizzBuzz for 1 through 100, with the label picked by a helper function.
// Run: node fizzbuzz.js

function fizzbuzzLabel(n) {
  if (n % 15 === 0) return "FizzBuzz";
  if (n % 3 === 0) return "Fizz";
  if (n % 5 === 0) return "Buzz";
  return String(n);
}

for (let n = 1; n <= 100; n += 1) {
  console.log(fizzbuzzLabel(n));
}
