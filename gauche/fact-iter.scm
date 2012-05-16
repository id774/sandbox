(define (fact n)
  (define (fact-iter n ans)  
    (if (zero? n)
      ans
      (fact-iter (- n 1) (* n ans)))) ; call myself
  (fact-iter n 1))
