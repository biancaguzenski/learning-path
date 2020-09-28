fun is_older(pr1: int*int*int, pr2: int*int*int)=
   if (#1 pr1) < (#1 pr2) 
    then true
    else if(#1 pr1) > (#1 pr2)
    then false
    else
        if (#2 pr1) < (#2 pr2)
        then true
        else if(#2 pr1) > (#2 pr2)
        then false
        else
            if(#3 pr1) < (#3 pr2)
            then true
            else false
		     

fun number_in_month(x: (int*int*int) list, y: int)=
    if null x
    then 0
    else
	if #2 (hd x) = y
	then 1 + number_in_month(tl x, y)
	else
	    0

fun number_in_months(x: (int*int*int) list, y: int list)=
    if null x orelse null y
    then 0
	     
    else
	let fun helper(x: (int*int*int) list, z: int)=
		if null x
		then 0
		else
		    if #2 (hd x) = z
		    then 1 + helper(tl x, z)
		    else 0 + helper(tl x, z)
	in
	    helper(x, hd y) + number_in_months(x, tl y)
	end

fun dates_in_month(x: (int*int*int) list, y: int)=
    if null x
    then []
    else
	if #2 (hd x) = y
	then hd x :: dates_in_month(tl x, y)
	else
	    dates_in_month(tl x, y)

fun dates_in_months(x: (int*int*int) list, y: int list)=
	if null y
	then []
	else
	    dates_in_month(x, hd y) @ dates_in_months(x, tl y)

fun get_nth(x: string list, y: int)=
    if null x
    then ""
    else
	let fun nth(x: string list, y: int, z: int)=
		if y = z
		then hd x
		else nth(tl x, y, z+1)
	in
	    nth(x, y, 1)
	end

fun date_to_string(pr: int*int*int)=

    let val list = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	let fun helper(x: int, y: int, z: string list)=
		if x = y
		then hd list
		else
		    helper(x, y+1, z)
	in
	    helper(#2 pr, 1, list) ^ " " ^ Int.toString(#3 pr) ^ ", " ^ Int.toString(#1 pr)
	end
    end
	

fun number_before_reaching_sum(sum: int, list: int list)=
    if hd list < sum
    then 1 + number_before_reaching_sum((sum - (hd list)), tl list)
    else
	0
	    
fun what_month(day: int)=
    let
        val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, days_in_months) + 1
    end

fun month_range(x: int, y: int)=
    if x > y
    then []
    else
	what_month(x) :: month_range(x+1, y)

fun oldest(x: (int*int*int) list)=
    if null x
    then NONE
    else
	let val y = oldest(tl x)
	in
	    if isSome y andalso is_older(valOf y, hd x)
	    then y
	    else
		SOME(hd x)
	end
	    
				    
			  
				    
	
	
