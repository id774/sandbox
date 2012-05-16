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
