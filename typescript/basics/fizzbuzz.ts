// Print FizzBuzz for 1 through 100, with the label picked by a typed helper function.
// Run: tsc --target es2020 fizzbuzz.ts && node fizzbuzz.js

function fizzbuzzLabel(n: number): string {
    if (n % 15 === 0) return "FizzBuzz";
    if (n % 3 === 0) return "Fizz";
    if (n % 5 === 0) return "Buzz";
    return String(n);
}

for (let n = 1; n <= 100; n++) {
    console.log(fizzbuzzLabel(n));
}
