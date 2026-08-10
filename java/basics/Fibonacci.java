// Print the first 20 Fibonacci numbers from a stream iterated over a pair of longs.
// Run: java Fibonacci.java

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
