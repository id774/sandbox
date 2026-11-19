;; next-method.scm: Delegate to a less specific method with next-method
;;
;; Description:
;; Specialize a generic method and delegate to the previous one with
;; next-method.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh next-method.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

(define-method add (x y)
          (format #t "~s and ~s was passed.\n" x y))
(add '(1 2 3) #f)
(define-method add ((lst1 <list>) (lst2 <list>))
          (next-method)
          (append lst1 lst2))
(add '(1 2) '(a b c))
