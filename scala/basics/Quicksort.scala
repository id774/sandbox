// Sort a fixed list with a quicksort generic over any ordered element type.
// Run: scala-cli run Quicksort.scala

def quicksort[T](items: List[T])(using ordering: Ordering[T]): List[T] = items match
  case Nil => Nil
  case pivot :: rest =>
    val (smaller, larger) = rest.partition(x => ordering.lteq(x, pivot))
    quicksort(smaller) ::: pivot :: quicksort(larger)

@main def quicksortMain(): Unit =
  println(quicksort(List(5, 3, 8, 4, 2, 7, 1, 10, 9, 6)).mkString(" "))
