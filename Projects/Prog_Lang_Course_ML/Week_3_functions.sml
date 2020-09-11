(* First-class functions: functions can be passed as arguments of other functions, can be values of variables, can be part of tuples, can be anything - functions are values, so they can be used wherever you can put some value
In funtional programming this is a key concept - as well as avoid mutation, encourage recursion, style closer to mathematical definitions, etc *)

fun double x = x * 2
fun increment x = x + 1
val a_tuple = (double, increment(double 2), double(increment 7))
val ans = (#1 a_tuple) 3
		       

(* Higher order function: a function that takes functions as args or returns functions *)
(* function closure: function that uses outside bindings - the things that are on the environment, not only local *)

		       
		       (* functions as arguments - a way of refactoring *)

fun increment_n_times_lame (n, x) =
    if n = 0
    then x
    else 1 + increment_n_times_lame (n-1, x)

fun double_n_times_lame (n, x)=
    if n = 0
    then x
    else 2 * double_n_times_lame (n-1, x)

fun nth_tail_lame (n, xs)=
    if n = 0
    then xs
    else tl (nth_tail_lame (n-1, xs))

			   (* this 3 functions are written in a way they can be helped by other function to make things simpler *)

fun increment x = x+1 (* helper functions *)
fun double x = 2*x

fun n_times (f, n, x)=
    if n = 0
    then x
    else f (n_times(f, n-1, x))

val x1 = n_times(double, 4, 7) (* n_times to complete the task of double 4 7 times *)
val x2 = n_times(increment, 4, 7)
val x3 = n_times(tl, 2, [4, 8, 12, 16])
		

		(* polymorphic functions: takes whatever is the type passed *)

fun times_until_zero (f, x)=
    if x = 0 then 0 else 1 + times_until_zero (f, f x)

(* anonymous functions: they are written as fn  x => exp - you dont give a name because it wont be called and you use them only when you are only gonna use once - also, no recursion allowed in anonymous functions *)

fun triple_n_times (n, x)=
    n_times((fn x => 3*x), n, x)

	   (* map - a function that iterates over every item on the list modifying them accordingly *)

fun map (f, xs)= (* built in function for this: List.map *)
    case xs of
	[] => []
      | x::xs' => f(x)::map(f, xs')

val x1 = map((fn x => x + 3), [1, 2, 3])
val x2 = map(hd, [[1, 2, 3], [4, 5, 6]])

	    (* filter - a function that receives two args, one is a function that acts as a condition, and filter returns values that are true for this condition *)

fun filter (f, xs)=
    case xs of
	[] => []
      | x::xs' => if f x then x::(filter(f, xs')) else filter(f, xs')

fun is_even x=
    x mod 2 = 0

fun all_even x = filter(is_even, x)
		       
