// Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
// Run: java Pascal.java

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
