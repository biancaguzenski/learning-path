(* using records  - another way to build types *)

(* syntax: val nameofval, curly braces, field equals expression *)

val x = { bar = 1+3, baz = (true, false), foo = (1, true) }

	    (* to access records, you use #field nameofval *)
val me = { name = "Bianca", age = 20+5, status = (true, false) }

	     (* datatype bindings *)

datatype mytype = TwoInts of int*int (* Two ints and Str are constructores - they act like functions *)
	       | Str of string
               | Pizza (* Pizza is a direct value *)
		     (* in mytype you can have either a int*int, or a string or nothing *)

val a = Str "hi" (* this makes sense: Str as a constructor is a function from type string->mytype / The value is Str "hi" - the constuctor is like a tag *)
val b = TwoInts (1+2, 4)
val c = Str (* bound to string *)
val d = Pizza (* pizza is a value of type mytype *)
val e = a
	    
	    
