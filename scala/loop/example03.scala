// example03.scala: Time inserts into a mutable Scala HashMap
//
// Description:
// Time 100000 inserts into a mutable Scala HashMap.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     scalac example03.scala
//     scala Example01
//
// Requirements:
// - Scala 2, which accepts the procedure syntax of main
//

object Example01 {
  def main(args: Array[String]) {
    val m = new scala.collection.mutable.HashMap[Int,Int]; 
    var i = 0;
    var start = System.currentTimeMillis();
    while(i<100000) { i=i+1;m.put(i,i);};
    var end = System.currentTimeMillis();
    println(end-start);
    println(m.size)
  }
}
