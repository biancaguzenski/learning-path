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
