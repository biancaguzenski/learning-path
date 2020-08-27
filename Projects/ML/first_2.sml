(* nested functions: limiting scope *)


fun count_from_1(x: int)=
    let
	fun count(from: int, to: int)=
	    if from = to
	    then to :: []
	    else from :: count(from+1, to)
    in
	count(1, x)
    end
	
	     
fun count_from_1_better(x : int)= (* better version = reduce parameters *)
    let
	fun count(from: int)= (* this fun is available only in scope of count from 1*)
	    if (from = x) (* if same value, return empty list *)
	    then x :: []
	    else from :: count(from+1) (* else, return list with value counting until reach x *)
    in
	count(1)
    end

	(* find maximum number function: one example of bad usage of recursion and one good - benefiting from let *)

fun bad_max(x : int list)= (* bad max is not efficient: takes to much time *)
    if null x
    then 0
    else if null (tl x)
    then hd x
    else if hd x > bad_max(tl x)
    then hd x
    else bad_max(tl x)

fun good_max(x: int list)=
    if null x
    then 0
    else if null (tl x)
    then hd x
    else
	let val tl_ans = good_max(tl x)
	in if hd x > tl_ans
	   then hd x
	   else tl_ans
	end
	    
	    (* working with options type: how to make good max even better by raising an error in null case *)

fun better_max(x: int list)=
    if null x
    then NONE (* none means zero items for options *)
    else
	let val tl_ans = better_max(tl x)
	in if isSome tl_ans andalso valOf tl_ans > hd x (* isSome returns true if SOME and false if NONE; valOf returns value of SOME *)
	   then tl_ans
	   else SOME (hd x)
	end

fun best_max(x: int list)=
    if null x
    then NONE
    else
	let (* helper function in case it is not NONE *)
	    fun max_nonempty(x: int list)= (* the difference here is that we do not see if it is empty all the time with isSome *)
		if null (tl x)
		then hd x
		else
		    let val tl_ans = max_nonempty(tl x)
		    in
			if hd x > tl_ans
			then hd x
			else tl_ans
		    end
	in
	    SOME(max_nonempty(x))
	end
	    
			
	    
	    
