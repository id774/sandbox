// Print the first 20 Fibonacci numbers from a generator function.
// Run: node fibonacci.js

function* fibonacci() {
  let current = 0;
  let following = 1;
  while (true) {
    yield current;
    [current, following] = [following, current + following];
  }
}

function take(source, count) {
  const values = [];
  for (const value of source) {
    values.push(value);
    if (values.length === count) break;
  }
  return values;
}

console.log(take(fibonacci(), 20).join(" "));
