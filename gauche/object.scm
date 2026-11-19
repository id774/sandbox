;; object.scm: Class with init keywords and slot access
;;
;; Description:
;; Define a class with init keywords and read its slots two ways.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh object.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;

;; class
(define-class <book> ()
         ((author :init-keyword :author)
          (title  :init-keyword :title)))

;; instance
(define GaucheProgramming (make <book> 
                                     :title "Gaucheプログラミング"
                                     :author "だれか"))

(ref GaucheProgramming 'title)
(slot-ref GaucheProgramming 'author)
