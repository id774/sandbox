// Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a while loop.
// Run: java GcdLcm.java

public class GcdLcm {
    static final long[][] PAIRS = {{1071, 462}, {270, 192}, {17, 5}, {120, 36}};

    static long gcd(long first, long second) {
        while (second != 0) {
            long remainder = first % second;
            first = second;
            second = remainder;
        }
        return first;
    }

    public static void main(String[] args) {
        for (long[] pair : PAIRS) {
            long first = pair[0];
            long second = pair[1];
            long divisor = gcd(first, second);
            System.out.println(first + " " + second + " " + divisor + " " + first / divisor * second);
        }
    }
}
