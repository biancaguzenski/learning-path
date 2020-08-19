(* understanding variables *)

val y = 17 (* semicolon is optional here *)
val x = 12
val z = x+y

(* working with conditional *)
	      
val abs_of_z = if z < 0 then 0-z else z (* in sml, else is not optional *)
					  
(* working with functions *)
					  
fun pow(x:int, y:int) =
    if y = 0
    then 1
    else x * pow(x,y-1) (* no loops, use recursion *)

val ans = pow(2, 4)

fun cube(x) =
    pow(x, 3)

val ans_cube = cube(2) (* parenthesis use is optional when there is only one argument *)
		   
		
(* Pairs/tuples - tuples are fixed size and can have multiple data types *)

fun swap(pr: int*bool) =
    (#2pr, #1pr)

fun sum_pairs(pr1: int*int, pr2: int*int) =
    (#1pr1) + (#2pr1) + (#1pr2) + (#2pr2)

fun div_mod(x:int, y:int) =
    (x div y, x mod y)

fun sort_pair(pr: int*int)=
    if (#1pr) < (#2pr)
    then pr
    else (#2pr, #1pr)

(* Lists - not fixed in size, only one type *)

val list = [] (* use null function to verify if a list is empty *)
	       (* use :: to insert a element at beggining of list *)
	       (* use hd function to return first element and tl function to access other elements *)
	       
	     
	     
    
