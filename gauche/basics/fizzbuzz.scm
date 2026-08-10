;; Print FizzBuzz for 1 through 100, choosing the label with cond.
;; Run: gosh fizzbuzz.scm

(define (label n)
  (cond ((zero? (modulo n 15)) "FizzBuzz")
        ((zero? (modulo n 3)) "Fizz")
        ((zero? (modulo n 5)) "Buzz")
        (else (number->string n))))

(dotimes (i 100)
  (print (label (+ i 1))))
