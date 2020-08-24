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

fun sum_list(x: int list)= (* list is parameter *)
    if null x
    then 0
    else hd x + sum_list(tl x)

fun countdown(x: int)= (* function return list *)
    if x = 0
    then []
    else x :: countdown(x - 1)
		       

fun append(x: int list, y: int list)=
    if null x
    then y
    else (hd x) :: append(tl x, y)

fun sum_pairs(x: (int*int) list)=
    if null x
    then 0
    else #1(hd x) + #2(hd x) + sum_pairs(tl x)

fun first(x: (int*int) list)=
    if null x
    then []
    else #1(hd x) :: first(tl x)

fun second(x: (int*int) list)=
    if null x
    then []
    else #2(hd x) :: second(tl x)

fun list_product(x: int list)=
    if null x
    then 1
    else hd x * list_product(tl x)
			    
fun factorial(x: int)=
    list_product(countdown(x))

fun factorial_two(x: int)=
    if x <= 1
    then 1
    else x * factorial(x-1)
		      
			   
			  
			 
	     
	     
    
