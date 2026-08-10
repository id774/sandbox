;; Print the first 20 Fibonacci numbers from a lazy sequence built with iterate.
;; Run: clojure -M fibonacci.clj

(require '[clojure.string :as string])

(def fibonacci
  (map first (iterate (fn [[current next]] [next (+ current next)]) [0 1])))

(println (string/join " " (take 20 fibonacci)))
