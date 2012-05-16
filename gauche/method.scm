(define-method add (x y)
          (format #t "~s and ~s was passed.\n" x y))
(add '(1 2 3) #f)
