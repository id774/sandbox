;; Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recur loop.
;; Run: clojure -M gcd_lcm.clj

(require '[clojure.string :as string])

(def pairs [[1071 462] [270 192] [17 5] [120 36]])

(defn euclid [a b]
  (if (zero? b)
    a
    (recur b (mod a b))))

(doseq [[a b] pairs]
  (let [divisor (euclid a b)]
    (println (string/join " " [a b divisor (* (quot a divisor) b)]))))
