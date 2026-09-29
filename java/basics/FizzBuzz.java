// FizzBuzz.java: FizzBuzz for 1 through 100
//
// Description:
// Print FizzBuzz for 1 through 100, with the label returned by a helper method.
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
//     java FizzBuzz.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

public class FizzBuzz {
    static String label(int n) {
        if (n % 15 == 0) {
            return "FizzBuzz";
        }
        if (n % 3 == 0) {
            return "Fizz";
        }
        if (n % 5 == 0) {
            return "Buzz";
        }
        return Integer.toString(n);
    }

    public static void main(String[] args) {
        for (int n = 1; n <= 100; n++) {
            System.out.println(label(n));
        }
    }
}
