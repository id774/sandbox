// Multiply two fixed 3x3 integer matrices held as two dimensional arrays.
// Run: java Matrix.java

import java.util.Arrays;
import java.util.stream.Collectors;

public class Matrix {
    static final int SIZE = 3;
    static final int[][] LEFT = {{2, -1, 0}, {1, 3, 4}, {0, 5, -2}};
    static final int[][] RIGHT = {{1, 0, 2}, {-3, 1, 1}, {4, 2, 0}};

    static int[][] multiply(int[][] left, int[][] right) {
        int[][] product = new int[SIZE][SIZE];
        for (int i = 0; i < SIZE; i++) {
            for (int j = 0; j < SIZE; j++) {
                for (int k = 0; k < SIZE; k++) {
                    product[i][j] += left[i][k] * right[k][j];
                }
            }
        }
        return product;
    }

    static int determinant(int[][] m) {
        return m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
             - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
             + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);
    }

    public static void main(String[] args) {
        int[][] product = multiply(LEFT, RIGHT);

        for (int[] row : product) {
            System.out.println(Arrays.stream(row)
                    .mapToObj(Integer::toString)
                    .collect(Collectors.joining(" ")));
        }
        System.out.println(determinant(product));
    }
}
