(* studying file *)

(* function to return lenght of list - time complexity o(n) *)

fun lenght x=
    if null x
    then 0
    else
	1 + lenght(tl x)

(* append returns a new list with the elements of y after the elements of x *)
(* @ is a built-in function in ml that serves to this purpose *)
(* time complexity = o(n) *)
		  		  
fun append(x, y)=
    if null x
    then y
    else
	hd x::append(tl x, y)

(* reverse: takes an int list, reverse it using append function *)
		    
fun reverse x=
    if null x
    then []
    else
	reverse(tl x) @ [hd x]

fun reverse_prepend(x, y)=
    if null x
    then y
    else
	reverse_prepend(tl x, hd x::y)


