// Sort a fixed array with a quicksort generic over any Comparable element.
// Run: swift quicksort.swift

func quicksort<T: Comparable>(_ items: [T]) -> [T] {
    guard let pivot = items.first else { return [] }
    let rest = items.dropFirst()
    return quicksort(rest.filter { $0 <= pivot }) + [pivot] + quicksort(rest.filter { $0 > pivot })
}

let numbers = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6]
print(quicksort(numbers).map { String($0) }.joined(separator: " "))
