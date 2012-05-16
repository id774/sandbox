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
