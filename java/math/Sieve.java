// Sieve.java: Primes below 100 by the sieve of Eratosthenes
//
// Description:
// Print the primes below 100, sieved over a boolean array and gathered through an IntStream.
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
//     java Sieve.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Sieve {
    static final int LIMIT = 100;

    public static void main(String[] args) {
        boolean[] isPrime = new boolean[LIMIT];
        for (int n = 2; n < LIMIT; n++) {
            isPrime[n] = true;
        }

        for (int n = 2; n * n < LIMIT; n++) {
            if (!isPrime[n]) {
                continue;
            }
            for (int multiple = n * n; multiple < LIMIT; multiple += n) {
                isPrime[multiple] = false;
            }
        }

        String primes = IntStream.range(0, LIMIT)
                .filter(n -> isPrime[n])
                .mapToObj(Integer::toString)
                .collect(Collectors.joining(" "));
        System.out.println(primes);
    }
}
