#lang racket

; streams - sequences of infinite things

(define ones (lambda () (cons 1 ones)))

(define (f x) (cons x (lambda () (f (+ x 1))))) ; returns a pair of x and a thunk that when you call it give back the next pair
(define nats (lambda () (f 1)))

; option 2 - better style

(define nats1
  (letrec ([f (lambda (x) (cons x (lambda () f (+ x 1))))])
    (lambda () (f 1))))

; memoization

(define fibonnaci
  (letrec ([memo null] ; list of pairs - arg . result
           [f (lambda (x)
                (let ([ans (assoc x memo)]) ; assoc see if there is x inside memo
                (if ans ; if ans is inside memo, returns it
                    (cdr ans)
                    (let ([new-ans (if (or  (= x 1) (= x 2)) ; else, computates 
                                       1
                                       (+ (f (- x 1))
                                          (f (- x 2))))])
                      (begin
                        (set! memo (cons (cons new-ans) memo))
                        new-ans)))))]) ; after computating the new-ans, put it inside of memo and returns it
    f))
