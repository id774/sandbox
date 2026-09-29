// Fibonacci.java: The first 20 Fibonacci numbers
//
// Description:
// Print the first 20 Fibonacci numbers from a stream iterated over a pair of longs.
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
//     java Fibonacci.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Fibonacci {
    public static void main(String[] args) {
        String values = Stream.iterate(new long[] { 0, 1 }, pair -> new long[] { pair[1], pair[0] + pair[1] })
                .limit(20)
                .map(pair -> Long.toString(pair[0]))
                .collect(Collectors.joining(" "));
        System.out.println(values);
    }
}
