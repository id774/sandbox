// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: scala-cli run WordFrequency.scala

val text = "the quick brown fox jumps over the lazy dog the fox barks"

@main def wordFrequency(): Unit =
  val counts = text.split("\\s+").groupMapReduce(identity)(_ => 1)(_ + _)
  counts.toSeq
    .sortBy((word, count) => (-count, word))
    .foreach((word, count) => println(s"$word $count"))
