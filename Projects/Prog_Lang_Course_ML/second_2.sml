(* using datatypes *)

datatype exp =
	   Constant of int
	 | Negate of exp
	 | Add of exp * exp
	 | Mult of exp * exp

fun eval e =
    case e of
	 Constant i => i
       | Negate e2 => ~(eval e2)
       | Add(e1, e2) => (eval e1) + (eval e2)
       | Mult(e1, e2) => (eval e1) * (eval e2)

fun number_of_adds e=
    case e of
	Constant i => 0
      | Negate e2 => number_of_adds e2
      | Add(e1, e2) => 1 + number_of_adds e2 + number_of_adds e1
      | Mult(e1, e2) => number_of_adds e1 + number_of_adds e2

val ex_1 :exp = Add(Constant 19, Negate(Constant 4))

val ex_2 :int = eval ex_1
		     
val ex_add = number_of_adds(Mult(ex_1, ex_1))

fun max_constant e =
    case e of
	Constant i => i
      | Negate e2 => max_constant e2
      | Add(e1, e2) => Int.max(max_constant e1, max_constant e2)
      | Mult(e1, e2) => Int.max(max_constant e1, max_constant e2)

val test_1 = Add(Constant 19, Negate(Constant 4))
val nineteen = max_constant test_1
			    

					    
