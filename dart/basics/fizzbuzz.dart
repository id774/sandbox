// Print FizzBuzz for 1 through 100, choosing the label with a switch expression on a record.
// Run: dart run fizzbuzz.dart

String fizzBuzzLabel(int n) => switch ((n % 3, n % 5)) {
      (0, 0) => 'FizzBuzz',
      (0, _) => 'Fizz',
      (_, 0) => 'Buzz',
      _ => '$n',
    };

void main() {
  for (var n = 1; n <= 100; n++) {
    print(fizzBuzzLabel(n));
  }
}
