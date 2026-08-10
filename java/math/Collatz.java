// Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
// Run: java Collatz.java

public class Collatz {
    static final int LIMIT = 1000;

    static int chainLength(long start) {
        int length = 1;
        while (start != 1) {
            start = start % 2 == 0 ? start / 2 : start * 3 + 1;
            length++;
        }
        return length;
    }

    public static void main(String[] args) {
        int longest = 1;
        int best = 1;

        for (int start = 1; start < LIMIT; start++) {
            int length = chainLength(start);
            if (length > best) {
                longest = start;
                best = length;
            }
        }
        System.out.println(longest + " " + best);
    }
}
