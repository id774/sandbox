;; Count the words of a fixed text, most frequent first and alphabetically within a tie.
;; Run: clojure -M word_frequency.clj

(require '[clojure.string :as string])

(def text "the quick brown fox jumps over the lazy dog the fox barks")

(doseq [[word count] (sort-by (juxt (comp - val) key)
                              (frequencies (string/split text #"\s+")))]
  (println word count))
