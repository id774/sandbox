;; matrix.scm: Product and determinant of two fixed 3x3 integer matrices
;;
;; Description:
;; Multiply two fixed 3x3 integer matrices held as lists of lists.
;;
;; Part of the math cross-language exercise set: it reads no arguments or
;; standard input, keeps its data fixed in the source, uses integer
;; arithmetic only, and its output is the same as that of the same exercise
;; in every other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh matrix.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

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
