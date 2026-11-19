;; extent.scm: Two-dimensional point as a closure
;;
;; Description:
;; Build a 2D point as a closure that answers to coordinate names.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh extent.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

(define (make-2d-point x y)
  (lambda (operation)
     (cond ((equal? operation "x") x)
           ((equal? operation "y") y)
           (else #f))))
