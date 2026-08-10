;; Print the primes below 100, sieved by removing each prime's multiples from the candidates.
;; Run: clojure -M sieve.clj

(require '[clojure.string :as string])

(defn sieve [candidates]
  (if (empty? candidates)
    []
    (let [prime (first candidates)]
      (cons prime (sieve (remove #(zero? (mod % prime)) (rest candidates)))))))

(println (string/join " " (sieve (range 2 100))))
