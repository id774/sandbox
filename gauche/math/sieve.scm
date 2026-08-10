;; Print the primes below 100, sieved by filtering each prime's multiples out of the candidates.
;; Run: gosh sieve.scm

(define (sieve candidates)
  (if (null? candidates)
      '()
      (let ((prime (car candidates)))
        (cons prime
              (sieve (filter (lambda (n) (not (zero? (modulo n prime))))
                             (cdr candidates)))))))

(print (string-join (map number->string (sieve (iota 98 2))) " "))
