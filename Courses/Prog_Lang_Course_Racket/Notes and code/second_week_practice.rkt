#lang racket

(provide (all-defined-out))

(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct mult (e1 e2) #:transparent)

;  #:mutable is another option: gives us more functions that allow mutation, like (set-const-int!)

(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
        [(mult? e) (let ([v1 (const-int (eval-exp (mult-e1 e)))]
                         [v2 (const-int (eval-exp (mult-e2 e)))])
                     (const (* v1 v2)))]
        [else (error "invalid expression")]))