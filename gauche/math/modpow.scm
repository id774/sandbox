;; modpow.scm: Modular exponentiation of fixed triples by repeated squaring
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
;;     gosh modpow.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define cases '((2 1000 1000003) (3 200 50) (5 117 19) (10 18 9999991)))

(define (modpow base exponent modulus)
  (let walk ((base (modulo base modulus)) (exponent exponent) (result 1))
    (if (zero? exponent)
        result
        (walk (modulo (* base base) modulus)
              (quotient exponent 2)
              (if (odd? exponent) (modulo (* result base) modulus) result)))))

(for-each (lambda (triple)
            (let ((base (car triple))
                  (exponent (cadr triple))
                  (modulus (caddr triple)))
              (print (string-join (map number->string
                                       (list base exponent modulus
                                             (modpow base exponent modulus)))
                                  " "))))
          cases)
