// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Run: dart run collatz.dart

const limit = 1000;

int chainLength(int start) {
  var value = start;
  var length = 1;
  while (value != 1) {
    value = value.isEven ? value ~/ 2 : value * 3 + 1;
    length++;
  }
  return length;
}

void main() {
  var longest = 1;
  var best = 1;

  for (var start = 1; start < limit; start++) {
    final length = chainLength(start);
    if (length > best) {
      longest = start;
      best = length;
    }
  }

  print('$longest $best');
}
