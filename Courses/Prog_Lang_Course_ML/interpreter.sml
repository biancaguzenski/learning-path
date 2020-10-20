datatype exp =
	 Int of int
	 | Negate of exp
	 | Add of exp * exp
	 | String of string
	 | Rational of int * int
				 

exception BadResult of string

fun add_values(v1, v2) = (* helper *) 
    case (v1, v2) of
	(Int i, Int j) => Int (i+j)
      | (Int i, String s) => String(Int.toString i ^ s)
      | (String s, Int i) => String(s ^ Int.toString i)
      | (Int i, Rational(j, k)) => Rational(i*k+j, k) 
      | (Rational _, Int _) => add_values(v2, v1)
      | (String s, Rational(i, j)) => String(s ^ Int.toString i ^ "/" ^ Int.toString j)
      | (Rational(i, j), String s) => String(Int.toString i ^ "/" ^ Int.toString j ^ s)
      | (String s, String t) => String(s ^ t)
      | (Rational(i, j), Rational(k, l)) => Rational(i*l+j*k, j*l)
      | _ => raise BadResult "Non-values passed to add_values"

fun eval e =
    case e of
	Int _ => e
      | Negate e => (case eval e of
			 Int i => Int (~i)
		       | _ => raise BadResult "Non-int in negate")
      | Add(e1, e2) => add_values(eval e1, eval e2)
      | String _ => e
      | Rational _ => e
			  

fun toString e =
    case e of
	Int i => Int.toString i
      | Negate e => "-(" ^ (toString e) ^ ")"
      | Add(e1, e2) => "(" ^ (toString e1) ^ "+" ^ (toString e2) ^ ")"
      | String s => s
      | Rational(i, j) => Int.toString i ^ "/" ^ Int.toString j
							      
fun hasZero e=
    case e of
	Int i => i=0
      | Negate e => hasZero e
      | Add(e1, e2) => (hasZero e1) orelse (hasZero e2)
      | String _ => false
      | Rational(i, j) => i=0 
