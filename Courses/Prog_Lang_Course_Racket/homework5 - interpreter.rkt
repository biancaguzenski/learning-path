#lang racket
(provide (all-defined-out))

(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

(define (racketlist->mupllist list) ; takes an racket list and returns a mupl list
  (if (null? list) ; handle empty cases returning aunit
      aunit
      (apair (car list) (racketlist->mupllist (cdr list))))) ; else builds apair

(define (mupllist->racketlist list) ; takes a mupl list and returns a racket list
  (if (aunit? list) ; handle empty alist
      null
      (cons (apair-e1 list) (mupllist->racketlist (apair-e2 list))))) ; else build racket list with cons cell
  

;; Problem 2

(define (envlookup env str) ; function that look up a variable in environment - takes environment and var
  (cond [(null? env) (error "unbound variable during evaluation" str)] ; if no environment raise error
        [(equal? (car (car env)) str) (cdr (car env))] ; if var is in environment, return its value
        [#t (envlookup (cdr env) str)])) ; recursive call to look up the whole environment

(define (eval-under-env e env) ; evaluator, takes an expression and the environment
  (cond [(var? e) ; if e is an instance of var
         (envlookup env (var-string e))] ; look up the environment and find e
        [(add? e) ; if is an instance of add
         (let ([v1 (eval-under-env (add-e1 e) env)] ; eval v1 to see if it is an int
               [v2 (eval-under-env (add-e2 e) env)]) ; do the same to v2
           (if (and (int? v1) ; if both are ints
                    (int? v2))
               (int (+ (int-num v1)  ; sum their values
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))] ; else raise an error
        [(int? e) ; if int, return int value
         e]
        [(aunit? e) ; if aunit, return it
         e]
        [(closure? e) ; if a closure, return it
         e]
        [(fun? e) ; if e is a function, return a clojure with a environment for e and return e
         (closure env e)]
        [(ifgreater? e) ; evaluating ifgreater - evauate e1 and e2 to see if they are ints
         (let ([v1 (eval-under-env (ifgreater-e1) env)]
               [v2 (eval-under-env (ifgreater-e2) env)])
           (if (and (int? v1) (int? v2)) ; if they are, go to next segment
               (if (> (int-num v1) (int-num v2)) ; if v1 is bigger, evaluates e3
                   (eval-under-env (ifgreater-e3) env)
                   (eval-under-env (ifgreater-e4) env)) ; else evaluates e4
               (error "MUPL ifgreater not applied to two numbers")))] ; if v1 and v2 aren't ints raise error
        [(mlet? e)
         ;;; CONTINUE AQUI
        [#t (error (format "bad MUPL expression: ~v" e))])) ; if e is not a valid mupl expression, raise error

;; Do NOT change
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
