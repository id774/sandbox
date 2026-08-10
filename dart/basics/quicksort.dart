// Sort a fixed list with a quicksort generic over any Comparable element.
// The bound is Comparable<dynamic> because int implements Comparable<num>, not Comparable<int>.
// Run: dart run quicksort.dart

List<T> quicksort<T extends Comparable<dynamic>>(List<T> items) {
  if (items.length <= 1) return List<T>.of(items);
  final pivot = items.first;
  final rest = items.skip(1);
  final smaller = rest.where((x) => x.compareTo(pivot) <= 0).toList();
  final larger = rest.where((x) => x.compareTo(pivot) > 0).toList();
  return [...quicksort(smaller), pivot, ...quicksort(larger)];
}

void main() {
  final numbers = [5, 3, 8, 4, 2, 7, 1, 10, 9, 6];
  print(quicksort(numbers).join(' '));
}
