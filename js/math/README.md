# JavaScript math

The JavaScript half of the `math` exercise set: six small numeric programs that
every language directory carries in the same form. What each one computes and
the exact output it prints are stated once in the repository
[README](../../README.md#the-basics-directory); this file covers only what is
specific to JavaScript.

The set is integer arithmetic throughout, and that is worth a note here more
than in most languages: JavaScript has no integer type. Every value below is a
double, exact only while it stays within ±2^53. The exercises are sized to stay
inside that range — the largest intermediate value is the squaring step in
`modpow.js`, where a modulus just under 10^7 keeps `base * base` around 10^14 —
so the results are exact without `BigInt`. A larger modulus would need one.

## Files

| File | What it shows about JavaScript |
| --- | --- |
| `sieve.js` | An array of flags marked from `n * n`, then `reduce` to collect the survivors with their indices — the index is the number, so no second array is needed. |
| `gcd_lcm.js` | Euclid's algorithm written as a destructuring swap (`[first, second] = [second, first % second]`), which removes the temporary variable. |
| `collatz.js` | A running maximum over a plain loop. Halving is `value / 2` rather than a shift: JavaScript's bitwise operators coerce their operands to 32-bit integers, so a shift is not a general substitute for division here. |
| `matrix.js` | Multiplication as nested `map` with a `reduce` over the shared index, and a determinant taken by destructuring the three rows in the parameter list. |
| `pascal.js` | Each row summed from the previous one shifted both ways (`[0, ...row]` against `[...row, 0]`), so no index arithmetic appears. |
| `modpow.js` | Repeated squaring with `Math.floor(exponent / 2)`. The modulus keeps every product inside the exact range of a double. |

## Running

    node sieve.js
    node gcd_lcm.js
    node collatz.js
    node matrix.js
    node pascal.js
    node modpow.js

The header comment of each file gives the same command. No dependencies, no
build step.

## Notes

These six sit in a directory name that other languages also use for older,
unrelated snippets; here the directory holds the exercise set only. Output is
byte-identical to every other language's version, and nothing reads an
argument, standard input, a clock, or a random source.
