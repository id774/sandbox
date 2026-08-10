;; Print modular powers of fixed triples, each squared and halved by repeated squaring.
;; Run: clojure -M modpow.clj

(require '[clojure.string :as string])

(def cases [[2 1000 1000003] [3 200 50] [5 117 19] [10 18 9999991]])

(defn modpow [base exponent modulus]
  (loop [base (mod base modulus) exponent exponent result 1]
    (if (zero? exponent)
      result
      (recur (mod (* base base) modulus)
             (quot exponent 2)
             (if (odd? exponent) (mod (* result base) modulus) result)))))

(doseq [[base exponent modulus] cases]
  (println (string/join " " [base exponent modulus (modpow base exponent modulus)])))
