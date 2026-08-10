// Count the words of a fixed text, most frequent first and alphabetically within a tie.
// Run: java WordFrequency.java

import java.util.Arrays;
import java.util.Comparator;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class WordFrequency {
    private static final String TEXT = "the quick brown fox jumps over the lazy dog the fox barks";

    public static void main(String[] args) {
        Map<String, Long> counts = Arrays.stream(TEXT.split("\\s+"))
                .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));

        Comparator<Map.Entry<String, Long>> byCountThenWord =
                Comparator.<Map.Entry<String, Long>, Long>comparing(Map.Entry::getValue)
                        .reversed()
                        .thenComparing(Map.Entry::getKey);

        counts.entrySet().stream()
                .sorted(byCountThenWord)
                .forEach(entry -> System.out.println(entry.getKey() + " " + entry.getValue()));
    }
}
