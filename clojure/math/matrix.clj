;; matrix.clj: Product and determinant of two fixed 3x3 integer matrices
;;
;; Description:
;; Multiply two fixed 3x3 integer matrices, reaching the right one's columns with apply map vector.
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
;;     clojure -M matrix.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(def left [[2 -1 0] [1 3 4] [0 5 -2]])
(def right [[1 0 2] [-3 1 1] [4 2 0]])

(defn multiply [a b]
  (let [columns (apply map vector b)]
    (mapv (fn [row] (mapv #(reduce + (map * row %)) columns)) a)))

(defn determinant [[[a b c] [d e f] [g h i]]]
  (+ (- (* a (- (* e i) (* f h)))
        (* b (- (* d i) (* f g))))
     (* c (- (* d h) (* e g)))))

(let [product (multiply left right)]
  (doseq [row product]
    (println (string/join " " row)))
  (println (determinant product)))
