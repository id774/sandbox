(define-method add (x y)
          (format #t "~s and ~s was passed.\n" x y))
(add '(1 2 3) #f)
(define-method add ((lst1 <list>) (lst2 <list>))
          (next-method)
          (append lst1 lst2))
(add '(1 2) '(a b c))
