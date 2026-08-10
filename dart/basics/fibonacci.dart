// Print the first 20 Fibonacci numbers from a sync* generator.
// Run: dart run fibonacci.dart

Iterable<int> fibonacci() sync* {
  var current = 0;
  var next = 1;
  while (true) {
    yield current;
    final following = current + next;
    current = next;
    next = following;
  }
}

void main() {
  print(fibonacci().take(20).join(' '));
}
