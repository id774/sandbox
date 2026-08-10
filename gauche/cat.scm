#!/usr/bin/env gosh
;; Copy the named files, or standard input, to standard output.
 
(define (main args)   ;entry point
  (if (null? (cdr args))
      (copy-port (current-input-port) (current-output-port))
      (for-each (lambda (file)
                  (call-with-input-file file
                    (lambda (in)
                      (copy-port in (current-output-port)))))
                (cdr args)))
  0)
