#!/usr/bin/env gosh
;; weekday-name.scm: Weekday name for an index
;;
;; Description:
;; Return the weekday name for an index, or false when it is out of range.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh weekday-name.scm
;;
;; Requirements:
;; - Gauche (gosh)
;;
 
(define (weekday-name index)
  ((lambda (day-names)
    (if (or (< index 0)
            (> index 6))
        #f
        (list-ref day-names index)))
    (list "日" "月" "火" "水" "木" "金" "土")))
