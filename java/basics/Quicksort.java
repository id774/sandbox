// Sort a fixed list with a quicksort generic over any Comparable element.
// Run: java Quicksort.java

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
