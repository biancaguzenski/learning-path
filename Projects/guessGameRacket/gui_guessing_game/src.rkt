#lang racket
(require 2htdp/image)
(require 2htdp/universe)

(define (start lower upper)
  (big-bang (interval lower upper)
    (on-key deal-with-guess)
    (to-draw render)
    (stop-when single? render)))

; start the game

(struct interval (small big) #:transparent)

; interval is guess range

(define TEXT-SIZE 11)

(define HELP-TEXT
  (text "↑ for larger numbers, ↓ for smaller ones"
        TEXT-SIZE
        "blue"))
(define HELP-TEXT-2
  (text "Press = when your number is guessed, q to quit"
        TEXT-SIZE
        "blue"))
(define COLOR "red")
(define SIZE 72)
(define TEXT-X 3)
(define TEXT-UPPER-Y 10)
(define TEXT-LOWER-Y 135)
(define HEIGHT 150)
(define WIDTH (+ (image-width HELP-TEXT-2) 10))

(define MT-SC
  (place-image/align
   HELP-TEXT TEXT-X TEXT-UPPER-Y "left" "top"
   (place-image/align
    HELP-TEXT-2 TEXT-X TEXT-LOWER-Y "left" "bottom"
    (empty-scene WIDTH HEIGHT))))

(define (single? w) ; does the interval represent a single number?)
  (= (interval-small w) (interval-big w)))

(define (deal-with-guess w key)
  (cond [(key=? key "up") (big w)] ; key=? is provided in 2htdp/universe
        [(key=? key "down") (smaller w)]
        [(key=? key "q") (stop-with w)]
        [(key=? key "=") (stop-with w)]
        [else w]))

(define (smaller w)
  (interval (interval-small w)
            (max (interval-small w) (sub1 (guess w)))))

(define (big w)
  (interval (min (interval-big w) (add1 (guess w)))
            (interval-big w)))

(define (guess w) ; calculates guess based on given interval
  (quotient (+ (interval-small w) (interval-big w)) 2))

(define (render w)
  (overlay (text (number->string (guess w)) SIZE COLOR) MT-SC))