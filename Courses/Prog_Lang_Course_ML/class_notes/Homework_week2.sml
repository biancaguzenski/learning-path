fun only_capitals list=
    List.filter (fn lst => Char.isUpper(String.sub(lst, 0))) list
		(* List.filter = filter list and return only items that evaluate to true after passing through fn *)
		(* char.isupper returns true if char is uppercase*)
		(* string.sub returns the item in the ith position - in this case, in first postion, to see if it is uppercase *)
		(* ex: ["Aa", "Bb", "cc"] is passed as arg. List filter receives fn and list as args. fn sees if first letter in each string of the list starts with uppercase. If true, list filter returns it inside a new list. *)

fun longest_string list =
    List.foldl(fn(string, acc) => (*  the function f of foldl goes over substring s starting from left to right *)
		  if(String.size string > String.size acc) then string else acc) (* acc is the accumulator - it carries the greatest string so far *)
	     "" list

fun longest_string2 list =
    List.foldl(fn(string, acc) =>
		  if(String.size string >= String.size acc) then string else acc)
	      "" list

fun longest_string_helper =
    
											   
