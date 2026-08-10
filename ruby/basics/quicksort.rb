#!/usr/bin/env ruby
# Sort a fixed array with a quicksort over the head and tail of the array.

def quicksort(items)
  return items if items.size <= 1

  pivot, *rest = items
  quicksort(rest.select { |x| x <= pivot }) + [pivot] + quicksort(rest.select { |x| x > pivot })
end

puts quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6]).join(' ')
