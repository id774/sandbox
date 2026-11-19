;; fact-iter.scm: Factorial with an internal iterative helper
;;
;; Description:
;; Compute a factorial with an internal iterative helper.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh fact-iter.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

(define (fact n)
  (define (fact-iter n ans)  
    (if (zero? n)
      ans
      (fact-iter (- n 1) (* n ans)))) ; call myself
  (fact-iter n 1))
