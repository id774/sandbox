// Print the primes below 100, sieved over a boolean array and gathered through an IntStream.
// Run: java Sieve.java

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
