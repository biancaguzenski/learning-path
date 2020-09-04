(* studying file *)

(* function to return lenght of list - time complexity o(n) *)

fun lenght x=
    if null x
    then 0
    else
	1 + lenght(tl x)

(* append returns a new list with the elements of y after the elements of x *)
(* @ is a built-in function in ml that serves to this purpose *)
(* time complexity = o(n) *)
		  		  
fun append(x, y)=
    if null x
    then y
    else
	hd x::append(tl x, y)

(* reverse: takes an int list, reverse it using append function *)
		    
fun reverse x=
    if null x
    then []
    else
	reverse(tl x) @ [hd x]

(* other reverse option + prepend value *)
			    
fun reverse_prepend(x, y)=
    if null x
    then y
    else
	reverse_prepend(tl x, hd x::y)

		       (*

fun alternate x=
    if null x
    then []
    else
	let fun helper(x, y)=
		if null y
		then
		    hd x + helper(tl x, [1])
		else
		    hd x - helper(tl x, [])
	in
	    helper(x, [])
	end


		       *)

		       (*

fun min_max x=
    let val ans_0 = 
	    let fun max x =
		    if hd x > max(tl x)
		    then hd x
		    else
			max(tl x)
	    in
		max(x)
	    end
		let fun min x =
			if hd x < min(tl x)
			then hd
			else
			    min(tl x)
		in
		  min(x)
		end
    in
	(max x, min x)
    end
	
			
		
		    

		   
fun lengths([]) =0
  | lengths (a::y) = 1+lengths(y)

		       *)

fun leap_year x=
    (x mod 4 = 0) andalso (x mod 100 <> 0 orelse x mod 400 = 0)

fun two_fer (x: string option)=
    case x of
	SOME str => "One for " ^ str ^ " one for me"
      | NONE => "One for you, one for me" 
