exception NoAnswer

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string


fun only_capitals (str_list : string list) =
    List.filter (fn x => Char.isUpper(String.sub(x,0)))  str_list

fun longest_string1 (str_list : string list) =
    List.foldl (fn (x,y) => if String.size(x) > String.size(y) then x else y) "" str_list


fun longest_string2 (str_list : string list) =
    List.foldl (fn (x,y) => if String.size(x) >= String.size(y) then x else y) "" str_list


fun longest_string_helper compare_func str_list =
    List.foldl (fn (x,y) => if compare_func(String.size(x), String.size(y)) then x else y) "" str_list

fun longest_string3 (str_list : string list) =
    longest_string_helper (fn (x,y) => x > y) str_list

fun longest_string4 (str_list : string list) =
    longest_string_helper (fn (x,y) => x >= y) str_list

(* 5. Write a function longest_capitalized that takes a string list and returns
 the longest string in the list that begins with an uppercase letter, or "" if
 there are no such strings. Assume all strings have at least 1 character. Use a
 val-binding and the ML library’s o operator for composing functions. Resolve ties
 like in problem 2.*)
fun longest_capitalized str_list =
    (longest_string1 o only_capitals) (str_list)

(* 6. Write a function rev_string that takes a string and returns the string that
 is the same characters in reverse order. Use ML’s o operator, the library function
 rev for reversing lists, and two library functions in the String module. (Browse
 the module documentation to find the most useful functions.) *)
fun rev_string str =
    (String.implode o rev o String.explode) str

(* 7. Write a function first_answer of type (’a -> ’b option) -> ’a list -> ’b
 (notice the 2 arguments are curried). The first argument should be applied to
 elements of the second argument in order until the first time it returns SOME
 v for some v and then v is the result of the call to first_answer. If the first
 argument returns NONE for all list elements, then first_answer should raise the
 exception NoAnswer. Hints: Sample solution is 5 lines and does nothing fancy. *)
fun first_answer func1 some_list =
    case some_list of
        [] => raise NoAnswer
      | x::x' => let val return_val = func1 x
                 in case return_val of
                        SOME x => x
                      | _ => first_answer func1 x'
                 end

fun all_answers func1 some_list =
    let fun helper func lst lst_acc =
            case lst of
                [] => lst_acc
              | x::x' => case func x of
                             NONE => raise NoAnswer
                           | SOME y => (helper func x' (y @ lst_acc))
    in SOME (helper func1 some_list []) handle NoAnswer => NONE end

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(*f 9. (This problem uses the pattern datatype but is not really about pattern-matching.)
 A function g has been provided to you.
 (a) Use g to define a function count_wildcards that takes a pattern and returns how
 many Wildcard patterns it contains. *)
fun count_wildcards p =
    g (fn x => 1) (fn x => 0) p

(* (b) Use g to define a function count_wild_and_variable_lengths that takes a pattern
 and returns the number of Wildcard patterns it contains plus the sum of the string
 lengths of all the variables in the variable patterns it contains. (Use String.size.
 We care only about variable names; the constructor names are not relevant.) *)
fun count_wild_and_variable_lengths p =
    g (fn x => 1) (fn x => String.size(x)) p

(* (c) Use g to define a function count_some_var that takes a string and a pattern
 (as a pair) and returns the number of times the string appears as a variable in
 the pattern. We care only about variable names; the constructor names are not relevant. *)
fun count_some_var (s : string, p : pattern) =
    g (fn x => 0) (fn x => if x = s then 1 else 0) p


fun check_pat (p : pattern) =
    let fun get_strings pat =
            case pat of
                Variable z => [z]
             | TupleP ps => List.foldl (fn (p,i) => (get_strings p) @ i) [] ps
             | _ => []
        fun is_unique (str_lst : string list) =
            case str_lst of
                [] => true
              | x :: x' => if List.exists (fn y => y = x) x' then false else is_unique x'
    in is_unique (get_strings (p)) end


fun match (v : valu, p : pattern) =
    case p of
        Wildcard => SOME []
      | Variable s => SOME [(s, v)]
      | UnitP => (case v of 
                     Unit => SOME [] 
                   | _ => NONE)
      | ConstP i => (case v of 
                        Const j => if i = j then SOME [] else NONE
                      | _ => NONE)
      | TupleP lst => (case v of
                      Tuple t_lst => (all_answers (fn (x,y) => match(x,y)) (ListPair.zipEq(t_lst, lst)) handle UnequalLengths => NONE)
                                  | _ => NONE)
      | ConstructorP (s, pat) => (case v of
                                 Constructor (a, b) => if s = a then match(b, pat) else NONE
                                   | _ => NONE)

(* 12. Write a function first_match that takes a value and a list of patterns and returns a
(string * valu) list option, namely NONE if no pattern in the list matches or SOME lst
 where lst is the list of bindings for the first pattern in the list that matches.
 Use first_answer and a handle-expression. Hints: Sample solution is 3 lines. *)
fun first_match v p_lst =
    SOME (first_answer (fn x => match(v, x)) p_lst) handle NoAnswer => NONE
