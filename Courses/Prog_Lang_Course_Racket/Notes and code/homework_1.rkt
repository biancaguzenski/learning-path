#lang racket

(provide (all-defined-out)) ;;

(define (sequence low high stride)
  (if (> low high)
         null
         (let ([ans (+ low stride)])
           (cons low (sequence ans high stride )))))


(define (string-append-map xs suffix) 
  (map (lambda (str) ; map receives a procedure with an arg and passes through every element on the list
         (string-append str suffix)) xs)) ; and returns the value after applying this filter
; string-append is a built-in function that append in the end of a string, another string. String+suffix.

; write a function list-nth-mod that takes a list xs and a number n. If the number is negative,
;terminate the computation with (error "list-nth-mod: negative number"). Else if the list is
;empty, terminate the computation with (error "list-nth-mod: empty list"). Else return the i
;th
;element of the list where we count from zero and i is the remainder produced when dividing n by the
;list’s length. Library functions length, remainder, car, and list-tail are all useful – see the Racket
;documentation. Sample solution is 6 lines

(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")] ; cond for nested ifs
         [(null? xs) (error "list-nth-mod: empty list")]
         [#t (let ([x (remainder n (length xs))]) ; create a symbol to hold remainder value
                (car (list-tail xs x)))])) ; list-tail takes a list and a value and returns the sub-list starting from x position

(define ones (lambda () (cons 1 ones))) ; helper stream for testin 

(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([next (s)]) ; bound stream to next
        (cons (car next) (stream-for-n-steps (cdr next) (- n 1)))))) ; returns a list with car of next and the cdr
;of stream for n times

(define funny-number-stream
  (letrec ([f (lambda (x) ; letrec to allow recursive call of f
                (cons (if (= (remainder x 5) 0) (- 0 x) x)
                    (lambda () (f (+ x 1)))))]); if you can divide by 5, return it negative
    (lambda () (f 1))))

(define dan-then-dog
  (lambda () (cons "dan.jpg" ; must start with dan
                   (lambda () (cons "dog.jpg" dan-then-dog)))))

;(define (stream-add-zero s)
  
    

; 7.
(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

; 8.
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) 
                      (lambda () (f (+ 1 n)))))])
    (lambda () (f 0))))

; 9.
(define (vector-assoc v vec)
  (letrec ([f (lambda (n)
                (if (> n (- (vector-length vec) 1))
                    #f
                    (if (pair? (vector-ref vec n))
                        (if (equal? (car (vector-ref vec n)) v)
                            (vector-ref vec n)
                            (f (+ n 1)))
                        (f (+ n 1)))))])
    (f 0)))

; 10.
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [index 0])
    (lambda (v)
      (if (vector-assoc v cache)
          (vector-assoc v cache)
          (let ([cur-val (assoc v xs)])
            (begin
              (vector-set! cache index cur-val)
              (set! index
                    (remainder (+ index 1) n))
              (vector-assoc v cache)))))))
