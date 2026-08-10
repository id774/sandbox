#!/usr/bin/env python3
# Sort a fixed list with a quicksort over the head and tail of the list.


def quicksort(items):
    if len(items) <= 1:
        return list(items)

    pivot, *rest = items
    smaller = [x for x in rest if x <= pivot]
    larger = [x for x in rest if x > pivot]
    return quicksort(smaller) + [pivot] + quicksort(larger)


print(" ".join(str(value) for value in quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6])))
