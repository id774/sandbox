// Sort a fixed array with a quicksort taking the comparison as a callback.
// Run: tsc --target es2020 quicksort.ts && node quicksort.js

function quicksort<T>(items: readonly T[], compare: (a: T, b: T) => number): T[] {
    if (items.length <= 1) return [...items];
    const [pivot, ...rest] = items;
    const smaller = rest.filter((x) => compare(x, pivot) <= 0);
    const larger = rest.filter((x) => compare(x, pivot) > 0);
    return [...quicksort(smaller, compare), pivot, ...quicksort(larger, compare)];
}

const unsorted = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
console.log(quicksort(unsorted, (a, b) => a - b).join(" "));
