#lang racket

; interpreter for arithmetic operations in racket language - rackibs

(provide (all-defined-out))

; this language has two types: bools and numbers

(struct const (int) #:transparent) ; int holds a number
(struct negate (e) #:transparent) ; holds an expression
(struct add (e1 e2) #:transparent) ; holds 2 expressions
(struct multiply (e1 e2) #:transparent) ; holds 2 expressions
(struct bool (b) #:transparent) ; holds true or false
(struct eq-num (e1 e2) #:transparent) ; holds 2 expressions
(struct if-then-else (e1 e2 e3) #:transparent) ; holds 3 expressions

(define (evaluator e)
  (cond [(const? e)
         e]
        [(negate? e)
         (let ([v (evaluator (negate-e e))])
           (if (const? v)
               (const (- (const-int v)))
               (error "negate applied to a non-number")))]
        [(add? e)
         (let ([v1 (evaluator (add-e1 e))]
               [v2 (evaluator (add-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (+ (const-int v1) (const-int v2)))
               (error "add aplied to non-number!")))]
        [(multiply? e)
         (let ([v1 (evaluator (multiply-e1 e))]
               [v2 (evaluator (multiply-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (* (const-int v1) (const-int v2)))
               (error "multiply aplied to non-number!")))]
        [(bool? e)
         e]
        [(eq-num? e)
         (let ([v1 (evaluator (eq-num-e1))]
               [v2 (evaluator (eq-num-e2))])
           (if (and (const? v1) (const? v2))
               (bool (= (const-int v1) (const-int v2)))
               (error "eq-num aplied to non-number!")))]
        [(if-then-else? e)
         (let ([v-test (if-then-else-e1 e)])
           (if (bool? v-test)
               (evaluator if-then-else-e2 e)
               (evaluator if-then-else-e3 e))
           (error "if-then-else aplied to non-boolean!"))]
        [else error "Evaluator can't evaluate - expected expression!"]))


(define test1 (multiply (negate (add (const 2)
                                     (const 2)))
                        (const 7)))
 