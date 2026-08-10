// Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
// Run: dart run pascal.dart

const rows = 10;

void main() {
  var row = <int>[1];

  for (var i = 0; i < rows; i++) {
    print(row.join(' '));

    final shifted = [0, ...row];
    final padded = [...row, 0];
    row = [for (var j = 0; j < shifted.length; j++) shifted[j] + padded[j]];
  }
}
