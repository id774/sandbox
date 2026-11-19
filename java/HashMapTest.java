// HashMapTest.java: Store and read strings in a HashMap
//
// Description:
// Put two strings with surrounding spaces into a HashMap and print them back
// by key.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     javac HashMapTest.java
//     java HashMapTest
//
// Requirements:
// - A JDK 5 or later, which supports generics
//

import java.util.HashMap;

public class HashMapTest {
    public static void main(String [] args) {
        HashMap<String,String> map = new HashMap<String,String>();
        map.put("apple", "apple   ");
        map.put("grapes", "   grapes");
        System.out.println(map.get("apple"));
        System.out.println(map.get("grapes"));
    }
}
