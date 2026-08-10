# Sort a fixed array with a quicksort generic over any Comparable element.
# Run: crystal run quicksort.cr

def quicksort(items : Array(T)) : Array(T) forall T
  return items if items.size <= 1

  pivot = items.first
  rest = items[1..]
  quicksort(rest.select { |x| x <= pivot }) + [pivot] + quicksort(rest.select { |x| x > pivot })
end

puts quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join(" ")
