// ModPow.java: Modular exponentiation of fixed triples by repeated squaring
//
// Description:
// Print modular powers of fixed triples, each squared and shifted down rather than left to BigInteger.
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
//     java ModPow.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

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
