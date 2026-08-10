// Print the first 20 Fibonacci numbers from a generator function.
// Run: tsc --target es2020 fibonacci.ts && node fibonacci.js

function* fibonacci(): Generator<number> {
    let [current, next] = [0, 1];
    while (true) {
        yield current;
        [current, next] = [next, current + next];
    }
}

function take<T>(source: Iterable<T>, count: number): T[] {
    const values: T[] = [];
    for (const value of source) {
        values.push(value);
        if (values.length === count) break;
    }
    return values;
}

console.log(take(fibonacci(), 20).join(" "));
