#lang racket

(define new-stack ; creates new empty stack
  (lambda () (list)))

(define push ; push element
  (lambda (stack x)
    (cons x stack)))

(define (pop stack) ; removes first element
  (if (empty-stack? stack)
      "Empty stack"
      (cdr stack)))

(define stack->top car) ; returns top
(define stack->length length) ; returns length
(define stack? list?) ; is this a stack?
(define empty-stack? empty?) ; is this stack empty?