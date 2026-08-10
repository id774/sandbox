;; Print the start below 1000 with the longest Collatz sequence, tracked in a named let over the range.
;; Run: gosh collatz.scm

(define limit 1000)

(define (chain-length start)
  (let walk ((value start) (count 1))
    (if (= value 1)
        count
        (walk (if (even? value) (quotient value 2) (+ (* value 3) 1))
              (+ count 1)))))

(let walk ((start 1) (longest 1) (best 1))
  (if (= start limit)
      (print longest " " best)
      (let ((count (chain-length start)))
        (if (> count best)
            (walk (+ start 1) start count)
            (walk (+ start 1) longest best)))))
