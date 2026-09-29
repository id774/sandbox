// Pascal.java: The first 10 rows of Pascal's triangle
//
// Description:
// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
//
// Part of the math cross-language exercise set: it reads no arguments or
// standard input, keeps its data fixed in the source, uses integer
// arithmetic only, and its output is the same as that of the same exercise
// in every other language. The exercises are specified in README.md at the
// repository root.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     java Pascal.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

import java.util.Arrays;
import java.util.stream.Collectors;

public class Pascal {
    static final int ROWS = 10;

    public static void main(String[] args) {
        long[] row = new long[ROWS + 1];
        row[0] = 1;

        for (int length = 1; length <= ROWS; length++) {
            System.out.println(Arrays.stream(row, 0, length)
                    .mapToObj(Long::toString)
                    .collect(Collectors.joining(" ")));

            for (int i = length; i > 0; i--) {
                row[i] += row[i - 1];
            }
        }
    }
}
