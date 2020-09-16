#lang racket ; necessary to drRacket know what language we are running

(provide (all-defined-out)) ;this is to make modules public

; Racket is a functional dinamically-typed language and the syntax is very minimalist and uniform

(define a 3) ; this define a "variable" - bounds a to 3

(define b (+ a 5)) ; before every single function we have to put parenthesis. Here we bound b to a + 5. Everything in racket is prefix.

(define cube1 ; Anonymous function is written as: (lambda (x) e) wheren lambda indicates function, x is arg and e is the expression
  (lambda (x)
    (* x (* x x)))) ;first version of cube

(define cube2
  (lambda (x)
    (* x x x))) ; some functions like * can receive mutiple arguments => (lambda (x y z) e)

; Consult the Racket documentation to learn how to define your own variable-number-of-arguments functions.

(define (cube3 x) ; syntatic sugar: without lambda, you define the name inside parenthesis with its args
  (* x x x))

; unlike ml, you can use recursion in anonymous functions because the definition itself is in scope in the function body

(define pow ; pow => x to the power of y
  (lambda (x y)
    (if (= y 0) ; Conditional: (if e1 e2 e3) => e1 is condition, if true then e2 else e3)
        1 ; #t and #f are the syntax for true and false
        (* x (pow x (- y 1))))))
      ; anything that is not false or nil is true => if 10 5 2 evaluates to 5, because 10 is true.

(define (pow1 x y) ; version without lambda
  (if (= y 0)
      1
      (* x (pow x (- y 1)))))

; pow in curried version:

(define pow2
  (lambda (x)
    (lambda (y)
      (if (= y 0)
          1
          (* x ((pow2 x) (- y 1)))))))

; Building lists:
         ; null => empty list | null? return true for empty list
         ; cons => constuct list (or list ()) | (cons 4 (cons 5 null)) == (list 4 5)
         ; car => head of list
         ; cdr => tail of list

(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

; everything in racket is either an atom (#t, #f, 10, "hi", null, identifier, special form - lambda, define, if) or
; a sequence of things in parenthesis (t1, t2... tn)
; if the first thing in a sequence is not a special form, than this is a function call
; racket syntax is unambiguos

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

; number? is a function that returns true if ther arg is a number

(define (my-sum xs) ;this function takes a list that has numbers and lists inside
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (my-sum (cdr xs)))
          (+ (my-sum (car xs)) (my-sum (cdr xs)))))) ; if not number, then enter the list and sum what is inside

; COND => a better style for nested conditionals
; the last condition must always be true so you dont fall off the bottom

(define (my-sum2 xs)
  (cond [(null? xs) 0] ; evaluates e1, if true, e2, else, skip to next branch
        [number? (car xs) (+ (car xs) (my-sum2 (cdr xs)))]
        [#t (+ (my-sum2 (car xs)) (my-sum2 (cdr xs)))]))

(define (my-sum3 xs)
  (cond [(null? xs) 0]
        [(number? xs) xs]
        [(list? xs) (+ (sum (car xs)) (sum (cdr xs)))]
        [#t 0])) ; this option will never raise error - if you insert string or something else, it will be ignored

; there are 4 types of local bindings: let, let*, letrec, define

; (let ([x1 e1]
;       [x2 e2] .. e) where x are local vars bound to results of e1, e2 etc. The body e can use this vars.
; We use the environment BEFORE let expression to evaluate e1, e2 etc

(define (double x)
  (let ([x (+ x 3)]
        [y (+ x 2)])
        (+ x y -5)))

; let* is used when you want to use the environment of the let expression

(define (double2 x)
  (let* ([x (+ x 2)]
        [y (+ x 3)])
    (+ x y -8)))

; letrec allows recursion

(define (triple x)
  (letrec ([y (+ x 2)]
           [f (lambda (z) (+ z y w x))]
           [w (+ x 7)])
    (f -9)))

; define we already know

