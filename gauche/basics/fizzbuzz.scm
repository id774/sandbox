;; fizzbuzz.scm: FizzBuzz for 1 through 100
;;
;; Description:
;; Print FizzBuzz for 1 through 100, choosing the label with cond.
;;
;; Part of the basics cross-language exercise set: the input is fixed in the
;; source, and the output is the same as that of the same exercise in every
;; other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh fizzbuzz.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define (label n)
  (cond ((zero? (modulo n 15)) "FizzBuzz")
        ((zero? (modulo n 3)) "Fizz")
        ((zero? (modulo n 5)) "Buzz")
        (else (number->string n))))

(dotimes (i 100)
  (print (label (+ i 1))))
