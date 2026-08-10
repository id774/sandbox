# Sort a fixed array with a quicksort over the destructured head and tail.
# Run: coffee quicksort.coffee

quicksort = (items) ->
  return items[..] if items.length <= 1

  [pivot, rest...] = items
  smaller = (x for x in rest when x <= pivot)
  larger = (x for x in rest when x > pivot)
  [quicksort(smaller)..., pivot, quicksort(larger)...]

console.log quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join ' '
