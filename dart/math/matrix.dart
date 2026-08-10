// Multiply two fixed 3x3 integer matrices held as lists of lists.
// Run: dart run matrix.dart

const size = 3;
const left = [
  [2, -1, 0],
  [1, 3, 4],
  [0, 5, -2],
];
const right = [
  [1, 0, 2],
  [-3, 1, 1],
  [4, 2, 0],
];

List<List<int>> multiply(List<List<int>> a, List<List<int>> b) {
  final product = [for (var i = 0; i < size; i++) List<int>.filled(size, 0)];

  for (var i = 0; i < size; i++) {
    for (var j = 0; j < size; j++) {
      for (var k = 0; k < size; k++) {
        product[i][j] += a[i][k] * b[k][j];
      }
    }
  }
  return product;
}

int determinant(List<List<int>> m) =>
    m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
    m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
    m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);

void main() {
  final product = multiply(left, right);

  for (final row in product) {
    print(row.join(' '));
  }
  print(determinant(product));
}
