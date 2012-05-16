(use gauche.test)

(add-load-path ".")
(load "square")

(test-start "square test")

;; First
(test-section "test group 1")
(test* "square 3" 9 (square 3))
(test* "square -2" 4 (square -2))

;; Second
(test-section "test group 2")
(test* "pass string argument" *test-error* (square "a"))

(test-end)
