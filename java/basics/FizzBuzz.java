// Print FizzBuzz for 1 through 100, with the label returned by a helper method.
// Run: java FizzBuzz.java

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
