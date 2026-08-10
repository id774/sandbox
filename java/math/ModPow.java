// Print modular powers of fixed triples, each squared and shifted down rather than left to BigInteger.
// Run: java ModPow.java

public class ModPow {
    static final long[][] CASES = {{2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}};

    static long modpow(long base, long exponent, long modulus) {
        long result = 1;
        base %= modulus;
        while (exponent > 0) {
            if ((exponent & 1) == 1) {
                result = result * base % modulus;
            }
            base = base * base % modulus;
            exponent >>= 1;
        }
        return result;
    }

    public static void main(String[] args) {
        for (long[] c : CASES) {
            System.out.println(c[0] + " " + c[1] + " " + c[2] + " " + modpow(c[0], c[1], c[2]));
        }
    }
}
