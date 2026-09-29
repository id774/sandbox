;; word_frequency.scm: Word frequencies of a fixed sentence
;;
;; Description:
;; Count the words of a fixed text, most frequent first and alphabetically within a tie.
;;
;; Part of the basics cross-language exercise set: the input is fixed in the
;; source, and the output is the same as that of the same exercise in every
;; other language. The exercises are specified in README.md at the
;; repository root.
;;
;; Author: id774 (More info: https://id774.net)
;; Source Code: https://github.com/id774/sandbox
;; License: The GPL version 3, or LGPL version 3 (Dual License).
;; Contact: idnanashi@gmail.com
;;
;; Usage:
;;     gosh word_frequency.scm
;;
;; Requirements:
;; - Gauche 0.9 or later (gosh)
;; - No third-party package is required

(define text "the quick brown fox jumps over the lazy dog the fox barks")

(define counts (make-hash-table 'string=?))

(for-each (lambda (word)
            (hash-table-update!/default counts word (lambda (n) (+ n 1)) 0))
          (string-split text " "))

(define ranked
  (sort (hash-table->alist counts)
        (lambda (a b)
          (if (= (cdr a) (cdr b))
              (string<? (car a) (car b))
              (> (cdr a) (cdr b))))))

(for-each (lambda (entry)
            (print (car entry) " " (cdr entry)))
          ranked)
