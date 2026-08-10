;; Multiply two fixed 3x3 integer matrices held as lists of lists.
;; Run: gosh matrix.scm

(define left '((2 -1 0) (1 3 4) (0 5 -2)))
(define right '((1 0 2) (-3 1 1) (4 2 0)))

(define (transpose matrix)
  (apply map list matrix))

(define (multiply a b)
  (let ((columns (transpose b)))
    (map (lambda (row)
           (map (lambda (column) (apply + (map * row column))) columns))
         a)))

(define (determinant m)
  (apply (lambda (a b c d e f g h i)
           (+ (- (* a (- (* e i) (* f h)))
                 (* b (- (* d i) (* f g))))
              (* c (- (* d h) (* e g)))))
         (apply append m)))

(let ((product (multiply left right)))
  (for-each (lambda (row) (print (string-join (map number->string row) " "))) product)
  (print (determinant product)))
