// Matrix.scala: Product and determinant of two fixed 3x3 integer matrices
//
// Description:
// Multiply two fixed 3x3 integer matrices, reaching the right one's columns with transpose.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     scala-cli run Matrix.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

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
