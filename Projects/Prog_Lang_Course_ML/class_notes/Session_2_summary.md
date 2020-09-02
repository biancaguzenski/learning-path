### Session 2 - summary

Programming languages have base types (like int and bool) and compound types, which are types that contain other thypes in their definition, like tuples and lists. We can create new compound types with 3 essential building blocks:
* Each of: compound type t describe values that contain each of values of type t2, t3... so on - like tuples
* One of: compound type t describe values that contains one of the types t2, t3... so on - like lists
* Self reference: compound type t may refer to itself in order to describe recursive data structures - like lists


**Records**: a way of build each-of types
* record expression build a record value
* the order of the fields doesn't matter - repl alphabetizes the record
* you acces by its name
* record = {bar = (1+2), baz = (true, false), foo = 1} - access first item: #bar record
* Tuples X Records - tuples are accesed by position, records are accessed by name - helps the decision when designing a language construct - which is more convenient?
* Tuple IS a record - tuple is a syntatic sugar for records - is convenient to use it sometimes


Datatype bindings - a way of build one-of types

```
datatype my_type = TwoInts of int*int
                |  Str of string
                |  Pizza
```


* In this case we have datatype keyword, the name of the new datatype, and its definition. My_type can be either a TwoInt where the value is int*iny, ot a Str with a string value, or nothing. TwoInt and Str are constructors, that can be also called tags. A constructor is two things: A function that create a specific value, or the value itself. In this example, TwoInts is a function of type int*int -> mytype, Str is a function of type string->mytype and Pizza is a value of type mytype. 
How to access data stored in mytype? For lists and options we have functions, like hd, tl and valOf. ML has case expressions for that:


```
fun f x = (* f is type mytype -> int *)
      case x of
        Pizza => 3
      |	TwoInts(i1, i2) => i1+i2
      |	Str s => String.size s
  ```

Case expression is like if-then-else expression. Case and of are keywords and x is the expression to match - either with pizza, TwoInts or Str - the first branch that matches.. Each branch has the form of p => e, where p is a pattern and e is an expression. We separate branches with pipe character. Case-expression is called pattern-matching. Ex, if TwoInts(7, 9) is passed to f, the second branch will be chosen.

Why are case-expressions better than function for testing variants and extracting pieces?

1. we can never mess up and try to extract something from the wrong variant - never gets exceptions like with hd []
2. if case-exp forgets a varuant or use a variant twice, you get an error message
3. Pattern-matching is more general and powerful

Examples

```
datatype suit = Club | Diamond | Heart | Spade
```
```
datatype rank = Jack | Queen | King | Ace | Num of int
```

We can combine two pieces: suit * rank

--

Other example:
```
datatype exp = Constant of int
	     | Negate of exp
	     | Add of exp*exp
	     | Multiply of exp*ex
	     
	     fun eval e =
	     	case e of
	     		Constant i => i
	     	      | Negate e2 =: ~(eval e2)
	     	      | Add(e1, e2) => (eval e1) + (eval e2)
	     	      | Multiply(e1, e2) => (eval e1) * (eval e2)
	     	      
	     eval(Add(Constant 19, Negate(Constant 4)) -> evaluates to 15
```

**Summarizing**
```
datatype t = C1 of t1 | C2 of t2 | ... | Cn of tn
```
Introduces datatype t and each constructor Ci is a function of type ti -> t > to get the pieces, we use a case expression

*case e of p1 => e1 | p2 => e2 | ... | pn => en*

evaluates e to a value v, finds the pattern p1 that matches v and evaluates e1 to produces the result of whole case expression.

**Type synonyms**

TYPE = create another name for an existing type - it is entirely interchangeable with the existing type

type foo = int > we can write foo wherever we write int and vice versa
It is convenient to create type synonyms when we have a complicated type.
Ex: type card = suit * rank
```
type name_record = {student num : int option;
		     first       : string,
		     middle      : string option.
		     last        : string }
```
	     	   
