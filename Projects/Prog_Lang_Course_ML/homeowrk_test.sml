use "homeowrk1.sml";

val test_1 = is_older((1990, 02, 02), (2002, 01, 03)) andalso not (is_older((1999, 01, 01), (1999, 01, 01)))
val test_2 = number_in_month([(1999, 02, 01), (1999, 02, 01)], 2) = 2
									
val test_3 = number_in_months([(1888, 12, 31), (1999, 9, 25), (2099, 7, 15), (2008, 9, 25)], [7, 9]) = 3 andalso (number_in_months([(1,2,25),(3,5,26),(1,12,29),(3,2,28),(1,2,27),(1,2,25),(6,7,8)], []) = 0)

val test4 = dates_in_month([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], 2) = [(22,2,1997), (25,2,1088)] andalso (null (dates_in_month([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], 4)))

val test5 = dates_in_months([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], [2, 3]) = [(22,2,1997), (25,2,1088), (23,3,1997)] andalso (null (dates_in_months([(21, 1, 1998), (22, 2, 1997), (23, 3, 1997), (25, 2, 1088)], [10, 11, 12]))) andalso (dates_in_months ([(1,2,25),(3,5,26),(1,12,29),(3,2,28),(1,2,27),(1,2,25),(6,7,8)], []) = [])

val test6 = get_nth(["aaaa","bbbb", "cccc", "dddd"], 3) = "cccc";

val test7 = date_to_string(1999, 12, 11) = "December 11, 1999";

val test8 = number_before_reaching_sum(15, [1, 2, 3, 4, 5, 6]) = 4 andalso (number_before_reaching_sum(15, [1, 2, 3, 4, 4, 5, 6]) = 5);

val test9 = what_month(300) = 10;

val test10 = month_range(31, 33) = [1, 2, 2] andalso (month_range(31, 2) = []);

val test11 = oldest([(2018, 10, 30), (2018, 10, 25), (2018, 10, 31), (1995, 11, 31)]) = SOME (1995,11,31) andalso (oldest [] = NONE);
