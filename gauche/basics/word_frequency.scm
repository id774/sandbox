;; Count the words of a fixed text, most frequent first and alphabetically within a tie.
;; Run: gosh word_frequency.scm

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
