datatype exp =
	 Int of int
	 | Negate of exp
	 | Add of exp * exp

exception BadResult of string

fun add_values(v1, v2) = (* helper *) 
    case (v1, v2) of
	(Int I, Int J) => Int (I+J)
      | _ => raise BadResult "Non-ints in addition"

fun eval e =
    case e of
	Int _ => e
      | Negate e => (case eval e of
			 Int i => Int (~i)
		       | _ => raise BadResult "Non-int in negate")
      | Add(e1, e2) => add_values(eval e1, eval e2)

fun toString e =
    case e of
	Int i => Int.toString i
      | Negate e => "-(" ^ (toString e) ^ ")"
      | Add(e1, e2) => "(" ^ (toString e1) ^ "+" ^ (toString e2) ^ ")"

fun hasZero e=
    case e of
	Int i => i=0
      | Negate e => hasZero e
      | Add(e1, e2) => (hasZero e1) orelse (hasZero e2) 
