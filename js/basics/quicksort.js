// Sort a fixed array with a quicksort over the destructured head and tail.
// Run: node quicksort.js

function quicksort(items) {
  if (items.length <= 1) return [...items];

  const [pivot, ...rest] = items;
  const smaller = rest.filter((x) => x <= pivot);
  const larger = rest.filter((x) => x > pivot);
  return [...quicksort(smaller), pivot, ...quicksort(larger)];
}

console.log(quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join(" "));
