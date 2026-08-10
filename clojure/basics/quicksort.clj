;; Sort a fixed vector with a quicksort over the destructured head and tail.
;; Run: clojure -M quicksort.clj

(require '[clojure.string :as string])

(defn quicksort [items]
  (if (empty? items)
    []
    (let [[pivot & rest] items]
      (concat (quicksort (filter #(<= % pivot) rest))
              [pivot]
              (quicksort (filter #(> % pivot) rest))))))

(println (string/join " " (quicksort [5 3 8 4 2 7 1 10 9 6])))
