# JavaScript basics

The JavaScript half of the `basics` exercise set: the same four programs every
language directory in this repository carries, so that one language can be read
against another. What each exercise does and the exact output it prints are
stated once in the repository [README](../../README.md#the-basics-directory);
this file covers only what is specific to JavaScript.

Each file is written the way JavaScript would write it rather than as a
transcription of a common solution, which is the point of having the set in
every language. All four run on Node with no dependencies and no build step.

## Files

| File | What it shows about JavaScript |
| --- | --- |
| `fizzbuzz.js` | A helper returning the label, so the loop body stays one `console.log`. `String(n)` rather than concatenation keeps the return type uniform. |
| `fibonacci.js` | A generator function (`function*`) with an infinite `while` loop, plus a `take` helper that stops after 20 — iteration as a lazy sequence, which is what generators are for. |
| `quicksort.js` | Destructuring the head and tail (`const [pivot, ...rest]`) and two `filter` passes, then spread to concatenate. Recursion over immutable arrays rather than in-place partitioning. |
| `word_frequency.js` | A `Map` for the counts, kept because it preserves insertion order and takes any key type, then one `sort` with a comparator that falls through from count to alphabetical order. |

## Running

    node fizzbuzz.js
    node fibonacci.js
    node quicksort.js
    node word_frequency.js

The header comment of each file gives the same command. There is nothing to
install: the four use only language built-ins, so any Node version from the
last several years runs them unchanged.

## Notes

Output is byte-identical to the other languages' versions of the same
exercises, which is the constraint the set is held to. Nothing here reads an
argument, standard input, a clock, or a random source, so the output cannot
drift between runs.
