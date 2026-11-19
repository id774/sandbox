;; method.scm: Generic method with untyped arguments
;;
;; Description:
;; Define a generic method and call it with untyped arguments.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh method.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

(define-method add (x y)
          (format #t "~s and ~s was passed.\n" x y))
(add '(1 2 3) #f)
