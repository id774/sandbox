// WordFrequency.java: Word frequencies of a fixed sentence
//
// Description:
// Count the words of a fixed text, most frequent first and alphabetically within a tie.
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
//     java WordFrequency.java
//
// Requirements:
// - JDK 17 or later
// - No third-party package is required

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
