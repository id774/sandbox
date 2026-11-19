// example01.scala: Time a for comprehension sum
//
// Description:
// Time a for comprehension that sums 100000 integers.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     scalac example01.scala
//     scala Example01
//
// Requirements:
// - Scala 2, which accepts the procedure syntax of main
//

object Example01 {
  def main(args: Array[String]) {
    var start = System.currentTimeMillis();
    var total = 0;for(i <- 0 until 100000) { total += i };
    var end = System.currentTimeMillis();
    println(end-start);
    println(total);
  }
}
