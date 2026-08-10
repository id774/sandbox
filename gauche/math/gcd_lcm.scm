;; Print the divisor and multiple of fixed pairs, with Euclid's algorithm written as a recursion.
;; Run: gosh gcd_lcm.scm

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
