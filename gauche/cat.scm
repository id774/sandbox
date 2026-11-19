#!/usr/bin/env gosh
;; cat.scm: Copy files or standard input to standard output
;;
;; Description:
;; Copy the named files, or standard input, to standard output.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh cat.scm [file...]
;;
;; Requirements:
;; - Gauche (gosh)
;;
 
(define (main args)   ;entry point
  (if (null? (cdr args))
      (copy-port (current-input-port) (current-output-port))
      (for-each (lambda (file)
                  (call-with-input-file file
                    (lambda (in)
                      (copy-port in (current-output-port)))))
                (cdr args)))
  0)
