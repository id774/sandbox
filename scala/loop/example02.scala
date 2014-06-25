object Example01 {
  def main(args: Array[String]) {
    var start = System.currentTimeMillis();
    var total = 0;var i=0;while(i < 100000) { i=i+1;total += i };
    var end = System.currentTimeMillis();
    println(end-start);
    println(total);
  }
}
