# To understand how dynamic dispatch differs from the lexical scope we used 
# for function calls, consider this simple ML code that defines two mutually 
# recursive functions:
# fun even x = if x=0 then true else odd (x-1)
# and odd x = if x=0 then false else even (x-1)
# This creates two closures that both have the other closure in their 
# environment. If we later shadow the even closure with something else, e.g.,
# fun even x = false
# that will not change how odd behaves. When odd looks up even in the environment 
# where odd was defined, it will get the function on the first line above. That is 
# “good” for understanding how odd works just from looking where is defined.

class A
    def even x
        if x == 0 then true else odd(x-1) end
    end
    def odd x
        if x == 0 then false else even(x-1) end
    end
end

class B < A
    def even x # changes B's odd too
        x % 2 == 0
    end
end


puts B.new.odd 17

# Now (B.new.odd 17) will execute faster because odd’s call to even 
# will resolve to the method in B – all because of what self is bound 
# to in the environment.