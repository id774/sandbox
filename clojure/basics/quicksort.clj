;; quicksort.clj: Quicksort of a fixed integer sequence
;;
;; Description:
;; Sort a fixed vector with a quicksort over the destructured head and tail.
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
;;     clojure -M quicksort.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(defn quicksort [items]
  (if (empty? items)
    []
    (let [[pivot & rest] items]
      (concat (quicksort (filter #(<= % pivot) rest))
              [pivot]
              (quicksort (filter #(> % pivot) rest))))))

(println (string/join " " (quicksort [5 3 8 4 2 7 1 10 9 6])))
