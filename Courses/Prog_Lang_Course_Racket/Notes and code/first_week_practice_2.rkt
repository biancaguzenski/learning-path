#lang racket
(provide (all-defined-out))


(define list (mcons 2 (mcons #t "hi"))) ; mcons build mutable lists
(set-mcar! list 10) ; mcons allow using set to change elements in lists

(define (factorial x) ; normal version of factorial
  (if (= x 0)
      1
      (* x (factorial (- x 1)))))

(define (my-bad-if e1 e2 e3)
  (if e1 e2 e3))

(define (bad-factorial x) ; this will never terminate => because it doesnt have a base case, it will always call bad-factorial again
  (my-bad-if (= x 0)
             1
             (bad-factorial (- x 1))))

(define (strange-if e1 e2 e3)
  (if e1 (e2) (e3))) ; here it either calls e1 or e2, just call the expression if e1 does that
; if you want to call a zero arg function, just put inside parenthesis

(define (strange-factorial x)
  (strange-if (= x 0)
              (lambda () 1) ; only one is gonna be called
              (lambda () (* x (strange-factorial (- x 1))))))
; delaying: put expression inside a function and dont call it - take an expression, replace with lambda, take no arguments of e and now you have a procedure that produces value only when called
; this process is called thunk

; if you have e, we evaluate and get the result
; if you have (lambda () e) - this is a function that you need to call
; (e) is the way to call the thunk