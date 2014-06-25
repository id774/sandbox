object Example01 {
  def main(args: Array[String]) {
    var start = System.currentTimeMillis();
    var total = 0;for(i <- 0 until 100000) { total += i };
    var end = System.currentTimeMillis();
    println(end-start);
    println(total);
  }
}
