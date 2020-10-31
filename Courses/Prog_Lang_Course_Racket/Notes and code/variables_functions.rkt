#lang racket

; (provide (all-defined-out))

; this is a comment

(define s "Hello, world") ; define is keyword for defining variables and functions.

(define x 3) ; how to define a variable

(define y (+ x 2)) ; defining y using x

(define cube1 ; defining a function
    (lambda (x) ; lambda is a keyword to function
        (* x (* x x)))) ; you can either do cube this way, or next 3 ways
(define cube2
    (lambda (x)
        (* x x x)))

(define (cube3 x) ; defining a function without lambda keyword
    (* x x x))

(define (pow1 x y) ; defining x to the power of y
    (if (= y 0)
        1
        (* x (pow1 x(- y 1)))))

(define pow2 ; another option of pow, using pow 1
  (lambda (x) ; pow2 takes a function with an arg x, its body is the other lambda
    (lambda (y) ; body of lambda x 
      (pow1 x y)))) ; and body of lambda y calls pow 1

(define answer (pow2 3))
  