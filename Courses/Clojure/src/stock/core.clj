(ns stock.core)

; name space: ns - espaço de memória do clojure

(println " Welcome to stock system ")

(defn apply-discount?                                       ; PREDICATE = return true/false
  [gross-value]
  (if (> gross-value 100)                                   ; this function can be an anonymous function
    true                                                    ; (fn [gross-value] (if (> gross-value 100))
    false))                                                 ; used directly as parameter of discount-value
; false here is optional
; when there is no else option, you can use keyword when instead of if
; direct version: instead of using if, just put what is inside parenthesis, it will be evaluated as true or false
; arity 0 means missing argument

; anonymous function in this case can be written as #(> %1 100) where # means function, %1 means first argument

(defn discount-value                                        ; define function
  [apply-discount? gross-value]                                             ; parameter: gross value
  (if (apply-discount? gross-value)                         ; if gross value is bigger than 100
    (let [discount-fee (/ 10 100)                           ; then apply discount. let = local variable.
          discount (* gross-value discount-fee)]            ; local var discount-fee = 10%
      (println "Discount =" discount)                       ; local var discount is gross-value * discount-fee
      (- gross-value discount))                             ; use both local vars here
    gross-value))                                           ; else, return gross value

(println (discount-value apply-discount? 1000))
(println (discount-value apply-discount? 100))                              ; code > reformat code
; removin/inserting parenthesis only with cut/paste

