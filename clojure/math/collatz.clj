;; collatz.clj: Longest Collatz sequence for a start below 1000
;;
;; Description:
;; Print the start below 1000 with the longest Collatz sequence, picked by max-key over a range.
;;
;; Part of the math cross-language exercise set: it reads no arguments or
;; standard input, keeps its data fixed in the source, uses integer
;; arithmetic only, and its output is the same as that of the same exercise
;; in every other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     clojure -M collatz.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(defn step [n]
  (if (even? n) (quot n 2) (inc (* n 3))))

(defn chain-length [start]
  (inc (count (take-while #(not= 1 %) (iterate step start)))))

(let [longest (apply max-key chain-length (range 1 1000))]
  (println longest (chain-length longest)))
