# This is a comment
# Ruby is a dinamically-typed pure OOP language.
# Ruby is a good choice for part C because  *all* the values are objects and that help us understand OOP
# Ruby is class-based, which means every object is an instance of a class, and the class determinates the
# methods and object has.
# Reflection: .class and .methods allow you to learn about the object.
# Blocks - are almost like closures and they are very used in ruby.
# Ruby is very dynamic and has semantics of a scripting language. Ruby shares much with Smalltalk with
# some nice additions.

#### RULES FOR OPP
# All values are references to objects, including result of evaluating expressions
# Objects communicate through messages - calling methods
# Each object has its own private state - Only methods can access or update this state
# Class determinates behavior

class Hello # Class name must be capitalized
    def hello() # Methods args can have a default value, like x=0. If so, all arguments to its right must also have a default.
        puts "Hello, World" # Methods returns its last expression
    end
end

hello = Hello.new # Each object is an instance of a class
# hello.hello - calling the method hello over the object hello
# To distinguish instance variable to local variable, we use an @ in front of the instance var - @hello
# Instance variables are private to the object
# Class variables: @@hello - shared by all instances of the class

class A
    def m1() # Parenthesis here are optional, but recommended. Have consistency.
        34
    end

    def m2(x, y)
        z = 7
        if x > y then false else x + y * z
        end
    end
end  

class B
    def m1()
        4
    end
    def m3(x)
        x.abs * 2 + self.m1 #self = myself, this object
    end
end

# e.m() to call the method over the object

class C
    def m1()
        print "hi"
        self
    end
    def m2()
        print "ok"
        self
    end
    def m3()
        print "bye"
        self
    end
end

class D
    def initialize(f=0) # Initialize is a method that is always called when you create an instance of the class
        @foo = f # Typical behavior for initialize is to create and initialize instance variables. 
    end
    def m1()
        @foo = 0
    end
    def m2(x)
        @foo += x
        @bar = 0
    end
    def foo()
        @foo
    end
end

# Most expressions in Ruby are actually method calls. Even e1 + e2 is just syntactic sugar for e1.+ e2.
# Ex: puts = convert to_s, print and add a new line - defined in class Object.

# Class constant - Capital letter, do not mutate and it is publicy visible.
# Outside of an instance of class C, you can access a constant Foo of C with the syntax C::Foo.
# An example is Math::PI.

class E
    Age = 38
    def self.reset_bar()
        @@bar = 0
    end
    def initialize(f=0)
        @foo = f
    end
    def m1(x)
        @foo += x
        @@bar += 1
    end
    def foo()
        @foo
    end
    def bar()
        @@bar
    end
end

# Visibility: private, public and protected
# Public means any object can call the method.
# Private, like with instance variables, allows only the object itself to call the method.
# Protected method can be called by any object that is an instance of the same class or any subclass of the class.
# Ways to specify visibility: 1) using keyowords between method definitions
# 2) shorter syntax: attr_accessor/reader/writer - both/getter/setter

# If you add a top-level method, it is added to class Object and becomes available to all methods

# Classes definitions are dynamic: give a class definition including method definitions for a class that is already defined.
# This is allowed but a bad idea!

## DUCK TYPING

# This refers to the idea that the class of an object (e.g., “Duck”) passed to a method is not important 
# so long as the object can respond to all the messages it is expected to (e.g., “walk to x” or “quack now”).

# Duck typing can make code more reusable, allowing clients to make “fake ducks” and still use your code.
# In Ruby, duck typing basically “comes for free” as long you do not explicitly check that arguments are
# instances of particular classes using methods like instance_of? or is_a?