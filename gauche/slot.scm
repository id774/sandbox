;; slot.scm: Virtual slot backed by external accessors
;;
;; Description:
;; Define a virtual slot backed by external accessor procedures.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh slot.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

(define ref-proc 'dummy)
(define set-proc 'dummy)
(let ((slot-val 'dummy))
  (set! ref-proc (lambda (obj) slot-val))
  (set! set-proc (lambda (obj new-val)
                   (set! slot-val new-val))))
(define-class <book> ()
  ((price :allocation :virtual 
         :slot-ref ref-proc
         :slot-set! set-proc)))
