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
		   
		
