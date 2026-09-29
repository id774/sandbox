;; quicksort.scm: Quicksort of a fixed integer sequence
;;
;; Description:
;; Sort a fixed list with a quicksort over the head and tail of the list.
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
;;     gosh quicksort.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define (quicksort items)
  (if (null? items)
      '()
      (let ((pivot (car items))
            (rest (cdr items)))
        (append (quicksort (filter (lambda (x) (<= x pivot)) rest))
                (list pivot)
                (quicksort (filter (lambda (x) (> x pivot)) rest))))))

(print (string-join (map number->string (quicksort '(5 3 8 4 2 7 1 10 9 6))) " "))
