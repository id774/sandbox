;; Print 10 rows of Pascal's triangle, taken from the lazy sequence each row of which maps the one before.
;; Run: clojure -M pascal.clj

(require '[clojure.string :as string])

(def rows
  (iterate (fn [row] (mapv + (cons 0 row) (conj row 0))) [1]))

(doseq [row (take 10 rows)]
  (println (string/join " " row)))
