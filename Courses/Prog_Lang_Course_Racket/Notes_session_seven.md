## Notes - Section 7 - Racket

### Introduction

- Racket and ML - more similarities than differences (like constructs that encourage functional style, allowing mutation only where appropriate)
- The differences are also many: the syntax, ML's support for pattern matching, Racket's accessors functions for structs, variants of let expressions (racket) and so forth.
- The biggest difference between then is the type system.

- Racketers can define ML as a subset of racket - they run in a similar wa, but ML rejects many programs as illegal - caused by static type system, that only allows a program to run if all the types are consistent
- One advantage of static type system might be seeing bugs in advance

- ML programmers view racket as a similar programming language where every expression is part of one big datatype - like a secret pattern-matching

 ### Type system: dynamic X static
 
 - Static checking = anything done to reject a program after it parses but before it runs (if dont parse, it is a syntax error, not a type error)
 - Type system depends on the construction of the programming language
 - When we studied ML, we gave typing rules for each language construct: Each variable had a type, the two branches of a conditional must have the same type, etc. ML’s static checking is checking that these rules are followed (and in ML’s case, inferring types to do so).
 - The purpose is to reject programs that “make no sense” or “may try to misuse a language feature.” There are errors a type system typically does not prevent (such as array-bounds errors) and others that a type system cannot prevent unless given more information about what a program is supposed to do. For example, if a program puts the branches of a conditional in the wrong order or calls + instead of *, this is still a program just not the one intended.

## Soundness  and completeness

- A type system is sound if it never accepts a program that, when run with some input, does X (no false-negatives). With static checking, the disease is “performs X when run with some input” and the test is “does the program type-check?”

- A type system is complete if it never rejects a program that, no matter what input it is run with, will not do X. (no false-positives)

- In modern languages, type systems are sound (they prevent what they claim to) but not complete (they reject programs they need not reject). Soundness is important because it lets language users and language implementers rely on X never happening. Completeness would be nice, but hopefully it is rare in practice that a program is rejected unnecessarily and in those cases, hopefully it is easy for the programmer to modify the program such that it type-checks.

SOUND = PREVENT WHAT THEY ARE SUPPOSED TO
COMPLETE = DO NOT REJECT PROGRAMS THEY ARE NOT SUPPOSED TO	

- Type systems are not complete because for almost anything you might like to check statically, it is impossible to implement a static checker that given any program in your language (a) always terminates, (b) is sound, and (c) is complete. Since we have to give up one, (c) seems like the best option (programmers do not like compilers that may not terminate).

### Weak type

- Suppose a type system is unsound for X - To be safe, the compiler must still ṕerform some dynamic checks to prevent errors

- But an alternative is to say it is the programmer’s fault if X happens and the language definition does not have to check. In fact, if X happens, then the running program can do anything: crash, corrupt data, produce the wrong answer, delete files, launch a virus, or set the computer on fire. If a language has programs where a legal implementation is allowed to set the computer on fire (even though it probably would not), we call the language weakly typed.

- C and C++ are the well-known weakly typed languages. Why are they defined this way? In short, because the designers do not want the language definition to force implementations to do all the dynamic checks that would be necessary. While there is a time cost to performing checks, the bigger problem is that the implementation has to keep around extra data (like tags on values) to do the checks and C/C++ are designed as lower-level languages where the programmer can expect extra “hidden fields” are not added. 


### Static checking

- ADVANTAGES: 
	- More convenient for preventing bugs (?) with type checking system
	- Static typing can lead to faster code since it does not need to perform type tests at run time. In fact, much of the performance advantage may result from not storing the type tags in the first place, which takes more space and slows down constructors.

- DIS:
	- Less convenient (?) for forcing to check datatypes before running
	- might prevent useful programs (?)

### Dynamic checking

- ADVANTAGES:
	- The argument that dynamic typing is more convenient stems from being able to mix-and-match different kinds of data such as numbers, strings, and pairs without having to declare new type definitions or “clutter” code with pattern-matching.
	 - Do not prevent useful programs
	 - Code reuse might be easier, but might cause more bugs

- DIS:
	- Might not prevent bugs unless it is tested
	- Dynamic typing has three reasonable counterarguments to lower performance. First, this sort of low-level performance does not matter in most software. Second, implementations of dynamically typed languages can and do try to optimize away type tests it can tell are unnecessary. For example, in (let ([x (+ y y)]) (* x 4)), the multiplication does not need to check that x and 4 are numbers and the addition can check y only once.
While no optimizer can remove all unnecessary tests from every program (undecidability strikes again), it may be easy enough in practice for the parts of programs where performance matters. Third, if programmers in statically typed languages have to work around type-system limitations, then those workarounds can erode the supposed performance advantages. After all, ML programs that use datatypes have tags too.


