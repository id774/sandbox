;; Sort a fixed list with a quicksort over the head and tail of the list.
;; Run: gosh quicksort.scm

(define (quicksort items)
  (if (null? items)
      '()
      (let ((pivot (car items))
            (rest (cdr items)))
        (append (quicksort (filter (lambda (x) (<= x pivot)) rest))
                (list pivot)
                (quicksort (filter (lambda (x) (> x pivot)) rest))))))

(print (string-join (map number->string (quicksort '(5 3 8 4 2 7 1 10 9 6))) " "))
