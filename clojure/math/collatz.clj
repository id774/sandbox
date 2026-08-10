;; Print the start below 1000 with the longest Collatz sequence, picked by max-key over a range.
;; Run: clojure -M collatz.clj

(defn step [n]
  (if (even? n) (quot n 2) (inc (* n 3))))

(defn chain-length [start]
  (inc (count (take-while #(not= 1 %) (iterate step start)))))

(let [longest (apply max-key chain-length (range 1 1000))]
  (println longest (chain-length longest)))
