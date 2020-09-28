fun fact x=
    case x of
	0 => 1
      | 1 => 1
      | _ => x * fact (x-1)
		      
fun fact_best_version x= (* tail recursion case *)
    let fun helper(x, acc)=
	    if x=0 then acc else helper(x-1, acc * x) (* remove stack of function calls *)
    in
	helper(x, 1)
    end

fun zip list_triple = (* this function takes a triple of lists and return a list of tuples *)
    case list_triple of
	([],[],[]) => [] 
       |(x::xs, y::ys, z::zs) => (x, y, z)::zip(xs, ys, zs)
       | _ => raise List.Empty

		    (* pattens: [] = empty
		        x::xs = at least one element
		        x::xs::[] = exactly two elements
		        x::y::xs = more than 2 elements *)
fun unzip list=
    case list of
	[] => ([], [], [])
      | (a, b, c)::tl => let val (l1, l2, l3) = unzip tl (* (a, b, c)::tl is the same as a::ax, b::bx, c::cx - is pattern match *)
			 in (a::l1, b::l2, c::l3) end

fun nondecreasing xs= (* returns true if list is oredered with nondecreasing values *)
    case xs of
	[] => true
      | x::[] => true
      | x::y::xs => x <= y andalso nondecreasing(y::xs)

datatype sign = P | N | Z (* p is for positive, n is for negative, z is for zero *)

fun mult_sign(x1, x2)= (* returns result sign of multiplication of x1 and x2 *)
    let fun helper x=
	    if x = 0 then Z else if x > 0 then P else N
    in
	case (helper x1, helper x2) of
	    (Z, _) => Z
	  | (_, Z) => Z
	  | (P, P) => P
	  | (N, N) => P
	  | _ => N
    end
	
fun length list =
    case list of
	[] => 0 
      | x::xs => 1 + length(xs)

fun append ([], y) = y
  | append (x::xs, y) = x::append(xs, y)

				 (* raising error messages: keyword exception to build a new one, raise to raise it or use an existing one *)

exception MyErrorMessageTesting

fun head_of xs=
    case xs of
	[] => raise MyErrorMessageTesting
      | x::_ => x
		    (* handling errors: use keyword handle - e1 handle exception => e2 *)

fun tail_of xs=
    case xs of
	[] => raise List.Empty
      | x::xs => xs
val testing_excep =  tail_of([]) handle List.Empty => [1]

						   
