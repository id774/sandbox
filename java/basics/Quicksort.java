// Quicksort.java: Quicksort of a fixed integer sequence
//
// Description:
// Sort a fixed list with a quicksort generic over any Comparable element.
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
//     java Quicksort.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Quicksort {
    static <T extends Comparable<T>> List<T> quicksort(List<T> items) {
        if (items.size() <= 1) {
            return new ArrayList<>(items);
        }

        T pivot = items.get(0);
        List<T> rest = items.subList(1, items.size());
        List<T> sorted = new ArrayList<>(quicksort(rest.stream().filter(x -> x.compareTo(pivot) <= 0).toList()));
        sorted.add(pivot);
        sorted.addAll(quicksort(rest.stream().filter(x -> x.compareTo(pivot) > 0).toList()));
        return sorted;
    }

    public static void main(String[] args) {
        List<Integer> numbers = List.of(5, 3, 8, 4, 2, 7, 1, 10, 9, 6);
        System.out.println(quicksort(numbers).stream().map(String::valueOf).collect(Collectors.joining(" ")));
    }
}
