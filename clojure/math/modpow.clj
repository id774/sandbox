;; modpow.clj: Modular exponentiation of fixed triples by repeated squaring
;;
;; Description:
;; Print modular powers of fixed triples, each squared and halved by repeated squaring.
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
;;     clojure -M modpow.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

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
