object Example01 {
  def main(args: Array[String]) {
    val m = new java.util.HashMap[Int,Int]; 
    var i = 0;
    var start = System.currentTimeMillis();
    while(i<100000) { i=i+1;m.put(i,i);};
    var end = System.currentTimeMillis();
    println(end-start);
    println(m.size)
  }
}
