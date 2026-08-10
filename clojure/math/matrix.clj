;; Multiply two fixed 3x3 integer matrices, reaching the right one's columns with apply map vector.
;; Run: clojure -M matrix.clj

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
