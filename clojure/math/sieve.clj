;; sieve.clj: Primes below 100 by the sieve of Eratosthenes
;;
;; Description:
;; Print the primes below 100, sieved by removing each prime's multiples from the candidates.
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
;;     clojure -M sieve.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(defn sieve [candidates]
  (if (empty? candidates)
    []
    (let [prime (first candidates)]
      (cons prime (sieve (remove #(zero? (mod % prime)) (rest candidates)))))))

(println (string/join " " (sieve (range 2 100))))
