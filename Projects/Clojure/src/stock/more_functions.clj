(ns stock.more_functions)

; use 'more_functions in rpl

(def prices [30, 70, 80])
(println (prices 0))                                        ; using list as function to print first item
(println (get prices 0))                                    ; get receives list and index
; if get receives an index out of bounds, it returns nil -> list as function returns error message
(println (conj prices 5))                                    ; create new list and returns it
(println prices)

(println (update prices 0 inc))                             ; increase 1
(println (update prices 0 dec))                             ; decrease 1
; update change list in specific index

(defn sum-1
  [value]
  (+ value 1))
(println (sum-1 3))

(println (update prices 0 sum-1))