;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out))

;; definition of structures for MUPL programs

(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) - "mlet = mupl let" 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

(define (racketlist->mupllist rlist)
  (if (null? rlist)
      aunit
      (apair (car rlist) (racketlist->mupllist (cdr rlist)))))

;testing: (racketlist->mupllist '(1 2))

(define (mupllist->racketlist mlist)
  (if (aunit? mlist)
      null
      (cons (apair-e1 mlist) (mupllist->racketlist (apair-e2 mlist)))))

; testing: (mupllist->racketlist (apair 1 (apair 2 (aunit))))


;; Problem 2

(define (envlookup env str) ; function to look up the environment when necessary
  (cond [(null? env) (error "unbound variable during evaluation" str)] ; tried to acces an undeclared var
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))


(define (eval-under-env e env) ; evaluate under environment
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        [(int? e)
         e]
        [(aunit? e)
         e]
        [(closure? e)
         e]
        [(fun? e)
         (closure env e)] ; treating functions as closures to bring the environment
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)] ; evaluate e1
               [v2 (eval-under-env (ifgreater-e2 e) env)]) ; evaluate e2
           (if (and (int? v1) (int? v2)) ; certify both are integers
               (if (> (int-num v1) (int-num v2)) ; evaluate if expression
                   (eval-under-env (ifgreater-e3 e) env) ; if true, evaluate e3
                   (eval-under-env (ifgreater-e4 e) env)) ; else, evaluate e4
               (error "MUPL ifgreater not applied to two numbers")))]
        [(mlet? e)
         (eval-under-env (mlet-body e) (cons (cons (mlet-var e) (eval-under-env (mlet-e e) env)) env))] ; evaluate mlet body, construct a pair of pair var name + value and its environment
        [(call? e)
         (let ([clos (eval-under-env (call-funexp e) env)])
           (if (closure? clos)
               (let ([locenv (closure-env clos)]
                     [funexp (closure-fun cos)]
                     [param (eval-under-env (call-actual e) env)])
                 (eval-under-env
                  (fun-body funexp)
                  (if (fun-nameopt funexp)
                      (cons (cons (fun-nameopt funexp) clos)
                            (cons (cons (fun-formal funexp) param) locenv))
                      (cons (cons (fun-formal funexp) param) locenv))))
               (error "MUPL call applied to non-closure")))]
        [(apair? e)
         (apair (eval-under-env (apair-e1 e) env)
                (eval-under-env (apair-e2 e) env))]
        [(fst? e)
         (let ([result (eval-under-env (fst-e e) env)])
           (if (apair? result)
               (apair-e1 result)
               (error "MUPL snd applied to non-apair")))]
        [(isaunit? e)
         (if (aunit? (eval-under-env (isaunit-e e) env))
             (int 1)
             (int 0))]        
        [#t (error (format "bad MUPL expression: ~v" e))]))


(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) "CHANGE")

(define (mlet* lstlst e2) "CHANGE")

(define (ifeq e1 e2 e3 e4) "CHANGE")

;; Problem 4

(define mupl-map "CHANGE")

(define mupl-mapAddN 
  (mlet "map" mupl-map
        "CHANGE (notice map is now in MUPL scope)"))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
