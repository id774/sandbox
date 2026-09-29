;; gcd_lcm.clj: GCD and LCM of fixed pairs by Euclid's algorithm
;;
;; Description:
;; Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recur loop.
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
;;     clojure -M gcd_lcm.clj
;;
;; Requirements:
;; - Clojure 1.11 or later, run through the Clojure CLI (clojure -M)
;; - Java 8 or later
;; - No third-party package is required

(require '[clojure.string :as string])

(def pairs [[1071 462] [270 192] [17 5] [120 36]])

(defn euclid [a b]
  (if (zero? b)
    a
    (recur b (mod a b))))

(doseq [[a b] pairs]
  (let [divisor (euclid a b)]
    (println (string/join " " [a b divisor (* (quot a divisor) b)]))))
