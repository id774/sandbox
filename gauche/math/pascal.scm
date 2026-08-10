;; Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
;; Run: gosh pascal.scm

(define rows 10)

(define (next row)
  (map + (cons 0 row) (append row '(0))))

(let walk ((row '(1)) (count 0))
  (when (< count rows)
    (print (string-join (map number->string row) " "))
    (walk (next row) (+ count 1))))
