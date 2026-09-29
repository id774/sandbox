// Quicksort.scala: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed list with a quicksort generic over any ordered element type.
//
// Part of the basics cross-language exercise set: the input is fixed in the
// source, and the output is the same as that of the same exercise in every
// other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     scala-cli run Quicksort.scala
//
// Requirements:
// - Scala CLI 1.0 or later (scala-cli)
// - Scala 3.0 or later
// - No third-party package is required

def quicksort[T](items: List[T])(using ordering: Ordering[T]): List[T] = items match
  case Nil => Nil
  case pivot :: rest =>
    val (smaller, larger) = rest.partition(x => ordering.lteq(x, pivot))
    quicksort(smaller) ::: pivot :: quicksort(larger)

@main def quicksortMain(): Unit =
  println(quicksort(List(5, 3, 8, 4, 2, 7, 1, 10, 9, 6)).mkString(" "))
