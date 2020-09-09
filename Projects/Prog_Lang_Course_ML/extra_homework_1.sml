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

		      
					   
datatype mytype = TwoInts of int * int
		| Str of string
       | Pizza

fun f x= (* x is evaluated and then it sees which branch matches - twoints, str or pizza - this is pattern matching *)
    case x of (* case exp to access pieces of a datatype - x is type mytype - f is mytype and returns int *)
	TwoInts(i, j) => i + j  (* in canse receive twoints, sum them *)
      | Str s => 1 (* if receive any string, return 1 *)
      | Pizza => 3 (* if pizza, then 3 *)
		     (* you cand call f with a string without using as well the constructor Str. If you call "f "hi"", you will have an error message. You need to call "f(Str "hi) to get 1 back *)

datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp * exp
	     | Mult of exp * exp
	     | Div of exp * exp
	     | Mod of exp * exp

fun eval e =
    case e of
	Constant i => i
      | Negate i => ~(eval i)
      | Add(i1, i2) => (eval i1) + (eval i2)
      | Mult(i1, i2)  => (eval i1) * (eval i2)
      | Div(i1, i2) => (eval i1) div (eval i2)
      | Mod(i1, i2) => (eval i1) mod (eval i2)

val test_1 = eval(Div(Constant 10, Constant 5))
		 
fun number_of_adds e =
    case e of
	Constant i => 0
      | Negate i => ~(eval i)
      | Add(i1, i2)  => 1 + number_of_adds(i1) + number_of_adds(i2)
      | Mult(i1, i2) =>  1 + number_of_adds(i1) + number_of_adds(i2)

fun max_constant e =
    let fun max_of_two(e1, e2)=
	    let val m1 = max_constant e1
		val m2 = max_constant e2
	    in if m1 > m2 then m1 else m2 end (* could have used function Int.max() from sml library *)
    in
	case e of
	    Constant i => i
	  | Negate i => max_constant(i)
	  | Add(i1, i2) => max_of_two(i1, i2)
	  | Mult(i1, i2) => max_of_two(i1, i2)
    end

fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(string, xs)=
    case xs of
	[] => NONE
      | x::xs' =>
	if same_string(string, x)
	then SOME xs'
	else
	    case all_except_option(string, xs') of
		NONE => NONE
	      | SOME a => SOME(x::a)
			       
