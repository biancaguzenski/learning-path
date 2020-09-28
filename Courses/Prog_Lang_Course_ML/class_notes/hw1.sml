fun is_older (d2: int*int*int, d1: int*int*int) =
    if #1 d2 > #1 d1
    then false
    else if #1 d2 < #1 d1
    then true
    else
        if #2 d2 > #2 d1
        then false
        else if #2 d2 < #2 d1
        then true
        else
            if #3 d2 > #3 d1
            then false
            else if #3 d2 < #3 d1
            then true    
            else false

fun number_in_month (lod:(int*int*int) list,mo:int) =
    if null lod
    then 0
    else if #2 (hd lod) = mo
        then 1 + number_in_month(tl lod, mo)
        else number_in_month(tl lod,mo)

fun number_in_months (lod:(int*int*int) list, lom:int list) =
    if null lom
    then 0
    else number_in_month(lod,hd lom) + number_in_months(lod, tl lom)

fun dates_in_month (lod:(int*int*int) list, mo:int) =
    if null lod
    then []
    else
        if #2 (hd lod) = mo
        then (hd lod)::dates_in_month(tl lod,mo)
        else dates_in_month(tl lod,mo)

fun append (xs : (int*int*int) list, ys : (int*int*int) list) =
    if null xs
    then ys
    else hd(xs) :: append(tl(xs), ys)

fun dates_in_months (lod : (int*int*int) list, lom : int list) =
    if null lom
    then []
    else append(dates_in_month(lod, hd lom),
                dates_in_months(lod, tl lom))
        
fun get_nth (los:'a list,n:int) =
    if n = 1
    then hd los
    else get_nth(tl los,n-1)

fun date_to_string (date:int*int*int) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(months,#2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end

fun number_before_reaching_sum (s:int, l:int list) =
    if s - hd l > 0
    then 1 + number_before_reaching_sum(s - hd l, tl l)
    else 0

fun what_month (day:int) =
    let
        val days_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
        1 + number_before_reaching_sum(day,days_in_months)
    end
        
fun month_range (day1:int,day2:int) =
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1+1,day2)        

fun oldest (d0:(int*int*int) list) =
    let
        fun oldest_nonempty(dates:(int*int*int) list) =
            if null(tl dates)
            then hd dates
            else
                let
                    val oldest_rest = oldest_nonempty(tl dates)
                in
                    if is_older(hd dates, oldest_rest)
                    then hd dates
                    else oldest_rest
                end
    in
        if null d0
        then
            NONE
        else
            SOME(oldest_nonempty(d0))
    end
        
fun remove_duplicates (lst:int list) =
    let
        fun remove_item(lst:int list,item:int) =
            if null lst
            then []
            else
                if (hd lst) = item
                then remove_item(tl lst,item)
                else (hd lst)::remove_item(tl lst,item)
    in
        if null lst
        then []
        else (hd lst)::remove_duplicates(remove_item(tl lst,hd lst))
    end

fun number_in_months_challenge (lod:(int*int*int) list, lom:int list) =
    number_in_months(lod,remove_duplicates(lom))

fun dates_in_months_challenge (lod:(int*int*int) list, lom:int list) =
    dates_in_months(lod,remove_duplicates(lom))
                    
fun reasonable_date (date:int*int*int) =
    let
        val yr = #1 date
        val mt = #2 date
        val day = #3 date
        val days_in_months = if (yr mod 4 = 0) andalso
                                 (not (yr mod 100 = 0) orelse (yr mod 400 = 0))
                             then [31,29,31,30,31,30,31,31,30,31,30,31]
                             else [31,28,31,30,31,30,31,31,30,31,30,31]
    in
        (yr > 0) andalso
        (mt > 0 andalso mt <= 12) andalso
        (day > 0 andalso day <= get_nth(days_in_months, mt))
    end
