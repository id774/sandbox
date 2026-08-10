// Print 10 rows of Pascal's triangle, taken from the lazy list each row of which zips the one before.
// Run: scala-cli run Pascal.scala

val rows: LazyList[Vector[Long]] =
  LazyList.iterate(Vector(1L))(row => (0L +: row).zip(row :+ 0L).map((left, right) => left + right))

@main def pascalMain(): Unit =
  rows.take(10).foreach(row => println(row.mkString(" ")))
