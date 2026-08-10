;; Print the first 20 Fibonacci numbers, accumulated by a tail-recursive named let.
;; Run: gosh fibonacci.scm

(define (fibonacci count)
  (let loop ((i 0) (current 0) (next 1) (acc '()))
    (if (= i count)
        (reverse acc)
        (loop (+ i 1) next (+ current next) (cons current acc)))))

(print (string-join (map number->string (fibonacci 20)) " "))
