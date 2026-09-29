;; gcd_lcm.scm: GCD and LCM of fixed pairs by Euclid's algorithm
;;
;; Description:
;; Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion.
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
;;     gosh gcd_lcm.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define pairs '((1071 462) (270 192) (17 5) (120 36)))

(define (euclid a b)
  (if (zero? b)
      a
      (euclid b (modulo a b))))

(for-each (lambda (pair)
            (let* ((a (car pair))
                   (b (cadr pair))
                   (divisor (euclid a b)))
              (print (string-join (map number->string
                                       (list a b divisor (* (quotient a divisor) b)))
                                  " "))))
          pairs)
