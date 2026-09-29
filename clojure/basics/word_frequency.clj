;; word_frequency.clj: Word frequencies of a fixed sentence
;;
;; Description:
;; Count the words of a fixed text, most frequent first and alphabetically within a tie.
;;
;; Part of the basics cross-language exercise set: the input is fixed in the
;; source, and the output is the same as that of the same exercise in every
;; other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     clojure -M word_frequency.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(def text "the quick brown fox jumps over the lazy dog the fox barks")

(doseq [[word count] (sort-by (juxt (comp - val) key)
                              (frequencies (string/split text #"\s+")))]
  (println word count))
