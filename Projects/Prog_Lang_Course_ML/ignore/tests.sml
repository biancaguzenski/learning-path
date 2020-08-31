fun return_tail(x: int list)=
    if null x
    then []
    else
	tl x :: return_tail(tl x)
