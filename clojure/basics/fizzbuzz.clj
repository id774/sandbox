;; Print FizzBuzz for 1 through 100, choosing the label with cond.
;; Run: clojure -M fizzbuzz.clj

(defn fizzbuzz-label [n]
  (cond
    (zero? (mod n 15)) "FizzBuzz"
    (zero? (mod n 3)) "Fizz"
    (zero? (mod n 5)) "Buzz"
    :else (str n)))

(doseq [n (range 1 101)]
  (println (fizzbuzz-label n)))
