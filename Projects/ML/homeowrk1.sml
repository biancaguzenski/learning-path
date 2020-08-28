fun is_older(pr1: int*int*int, pr2: int*int*int)=
    if #1 pr1 < #1 pr2
    then true
    else
	#2 pr1 < #2 pr2 orelse #3 pr1 < #3 pr2

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
	    []

fun dates_in_months(x: (int*int*int) list, y: int list)=
	if null y
	then []
	else
	    dates_in_month(x, hd y) @ dates_in_months(tl x, tl y)
