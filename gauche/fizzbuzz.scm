;; fizzbuzz.scm: FizzBuzz for 1 through 100
;;
;; Description:
;; Print FizzBuzz for 1 through 100.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh fizzbuzz.scm
;;
;; Requirements:
;; - Gauche (gosh) with srfi-1
;;

(use srfi-1)
(for-each 
 print
 (map
  (lambda (x) 
    (cond 
     ((= (modulo x 15) 0) "FizzBuzz")
     ((= (modulo x 5) 0) "Buzz")
     ((= (modulo x 3) 0) "Fizz")
     (else x)))
  (iota 100 1)))
