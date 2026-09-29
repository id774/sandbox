;; sieve.scm: Primes below 100 by the sieve of Eratosthenes
;;
;; Description:
;; Print the primes below 100, sieved by filtering each prime's multiples out of the candidates.
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
;;     gosh sieve.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define (sieve candidates)
  (if (null? candidates)
      '()
      (let ((prime (car candidates)))
        (cons prime
              (sieve (filter (lambda (n) (not (zero? (modulo n prime))))
                             (cdr candidates)))))))

(print (string-join (map number->string (sieve (iota 98 2))) " "))
