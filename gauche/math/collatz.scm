;; collatz.scm: Longest Collatz sequence for a start below 1000
;;
;; Description:
;; Print the start below 1000 with the longest Collatz sequence, tracked in a named let over the range.
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
;;     gosh collatz.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define limit 1000)

(define (chain-length start)
  (let walk ((value start) (count 1))
    (if (= value 1)
        count
        (walk (if (even? value) (quotient value 2) (+ (* value 3) 1))
              (+ count 1)))))

(let walk ((start 1) (longest 1) (best 1))
  (if (= start limit)
      (print longest " " best)
      (let ((count (chain-length start)))
        (if (> count best)
            (walk (+ start 1) start count)
            (walk (+ start 1) longest best)))))
