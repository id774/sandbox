;; fibonacci.scm: The first 20 Fibonacci numbers
;;
;; Description:
;; Print the first 20 Fibonacci numbers, accumulated by a tail-recursive named let.
;;
;; Part of the basics cross-language exercise set: the input is fixed in the
;; source, and the output is the same as that of the same exercise in every
;; other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh fibonacci.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define (fibonacci count)
  (let loop ((i 0) (current 0) (next 1) (acc '()))
    (if (= i count)
        (reverse acc)
        (loop (+ i 1) next (+ current next) (cons current acc)))))

(print (string-join (map number->string (fibonacci 20)) " "))
