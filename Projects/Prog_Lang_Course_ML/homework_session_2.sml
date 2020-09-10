fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(string, xs)=
    case xs of
	[] => NONE
      | x::xs' =>
	if same_string(string, x)
	then SOME xs'
	else
	    case all_except_option(string, xs') of
		NONE => NONE
	      | SOME a => SOME(x::a)

			      
fun get_substitutions1(xs, s) =
    case xs of
       [] => []
     | x :: xs' => case all_except_option(s, x) of
		      NONE => get_substitutions1(xs', s)
		    | SOME ls => ls @ get_substitutions1(xs', s)

fun get_substitutions2(xs, s)=
    let
        fun helper(xs, s, acc) =
            case xs of
               [] => acc
             | x :: xs' => case all_except_option(s, x) of
                NONE => helper(xs', s, acc)
              | SOME ls => helper(xs', s, ls @ acc)
    in
        helper(xs, s, [])
    end

fun similar_names(list, name)=
    let val {first = w, middle = y, last = z} = name
	fun get_names xs=
	    case xs of
		[] => []
	      | x::xs => {first = x, middle = y, last = z}::get_names(xs)
    in name::get_names(get_substitutions1(list, w))
    end
	
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color suit=
    case suit of
	Clubs => Black
      | Spades => Black
      | _  => Red

fun card_value card=
    case card of
	Ace => 11
      | Num x => x
      | _ => 10


fun remove_card(list, card, exp)=
    case list of
	[] => raise exp
     |  x:: xs => if card = x then xs else x::remove_card(xs, card, exp)

fun all_same_color list=
    case list of
	[] => true
      | x::y::xs => card_color(x) = card_color(y) andalso all_same_color(xs)

fun sum_cards cards=
    let fun helper(cards, acc)=
	    case cards of
		[] => acc
	      | x::xs => helper(xs, (card_value(x)+acc))
    in
	helper(cards, 0)
    end
	
