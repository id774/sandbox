// Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.
// Run: scala-cli run Matrix.scala

val left = Vector(Vector(2, -1, 0), Vector(1, 3, 4), Vector(0, 5, -2))
val right = Vector(Vector(1, 0, 2), Vector(-3, 1, 1), Vector(4, 2, 0))

def multiply(a: Vector[Vector[Int]], b: Vector[Vector[Int]]): Vector[Vector[Int]] =
  val columns = b.transpose
  a.map(row => columns.map(column => row.zip(column).map((x, y) => x * y).sum))

def determinant(m: Vector[Vector[Int]]): Int =
  m(0)(0) * (m(1)(1) * m(2)(2) - m(1)(2) * m(2)(1)) -
    m(0)(1) * (m(1)(0) * m(2)(2) - m(1)(2) * m(2)(0)) +
    m(0)(2) * (m(1)(0) * m(2)(1) - m(1)(1) * m(2)(0))

@main def matrixMain(): Unit =
  val product = multiply(left, right)
  product.foreach(row => println(row.mkString(" ")))
  println(determinant(product))
