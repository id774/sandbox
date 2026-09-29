;; pascal.clj: The first 10 rows of Pascal's triangle
;;
;; Description:
;; Print 10 rows of Pascal's triangle, taken from the lazy sequence each row of which maps the one before.
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
;;     clojure -M pascal.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(def rows
  (iterate (fn [row] (mapv + (cons 0 row) (conj row 0))) [1]))

(doseq [row (take 10 rows)]
  (println (string/join " " row)))
