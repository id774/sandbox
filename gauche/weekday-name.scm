#!/usr/bin/env gosh
 
(define (weekday-name index)
  ((lambda (day-names)
    (if (or (< index 0)
            (> index 6))
        #f
        (list-ref day-names index)))
    (list "日" "月" "火" "水" "木" "金" "土")))
