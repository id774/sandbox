;; pascal.scm: The first 10 rows of Pascal's triangle
;;
;; Description:
;; Print 10 rows of Pascal's triangle, each row summed from the previous one shifted both ways.
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
;;     gosh pascal.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define rows 10)

(define (next row)
  (map + (cons 0 row) (append row '(0))))

(let walk ((row '(1)) (count 0))
  (when (< count rows)
    (print (string-join (map number->string row) " "))
    (walk (next row) (+ count 1))))
