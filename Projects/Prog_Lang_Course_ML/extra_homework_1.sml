(* 1) Write a function alternate : int list -> int|alternate : int list -> int that takes a list 
of numbers and adds them with alternating sign. For example alternate [1,2,3,4] = 1 - 2 + 3 - 4 = -2 *)

fun alternate x=
    if null x
    then 0
    else if null(tl x)
	 then hd x
	 else hd x - hd(tl x) + alternate(tl(tl x))
				    
(* 2) Write a function min_max :  int list -> int * int that takes a non-empty list of numbers
and returns a pair (min, max) of the minimum and maximum of the numbers in the list. *)


(* helper functions to min_max function: smallest and biggest *)
					 
fun smallest [] = NONE
  | smallest (x::xs) = case smallest xs of
                       NONE => SOME x
                     | SOME y => if x < y
                                 then SOME x
                                 else SOME y

fun biggest [] = NONE
  | biggest (x::xs) = case biggest xs of
			  NONE => SOME x
			| SOME y => if x > y
				    then SOME x
				    else SOME y

fun min_max x=
    (valOf(smallest(x)), valOf(biggest(x)))

fun cumsum x=
    if null x
    then []
    else hd x::[hd x + cumsum(tl x)]
		   let fun helper(x::xs, sum)=
			   let val foo = x + sum in foo::helper(xs, foo) end
			 | helper([], _) = []
		   in helper(xs, 0)
		   end
		   
					      
					   
