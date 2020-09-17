(ns stock.core)

; name space: ns - espaço de memória do clojure

(println " Welcome to stock system ")

(defn apply-discount?                                       ; PREDICATE = return true/false
  [gross-value]
  (if (> gross-value 100)
    true
    false))                                                 ; false here is optional
; when there is no else option, you can use keyword when instead of if
; direct version: instead of using if, just put what is inside parenthesis, it will be evaluated as true or false
; arity 0 means missing argument

(defn discount-value                                        ; define function
  [gross-value]                                             ; parameter: gross value
  (if (apply-discount? gross-value)                         ; if gross value is bigger than 100
    (let [discount-fee (/ 10 100)                           ; then apply discount. let = local variable.
          discount (* gross-value discount-fee)]            ; local var discount-fee = 10%
      (println "Calculando desconto de " discount)          ; local var discount is gross-value * discount-fee
      (- gross-value discount))                             ; use both local vars here
    gross-value))                                           ; else, return gross value

(println (discount-value 1000))
(println (discount-value 100))