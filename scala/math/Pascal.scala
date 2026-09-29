// Pascal.scala: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, taken from the lazy list each row of which zips the one before.
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
//     scala-cli run Pascal.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

val rows: LazyList[Vector[Long]] =
  LazyList.iterate(Vector(1L))(row => (0L +: row).zip(row :+ 0L).map((left, right) => left + right))

@main def pascalMain(): Unit =
  rows.take(10).foreach(row => println(row.mkString(" ")))
