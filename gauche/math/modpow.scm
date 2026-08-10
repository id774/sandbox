;; Print modular powers of fixed triples, each squared and halved by repeated squaring.
;; Run: gosh modpow.scm

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
