require_relative 'Subclassing'

class ThreeDPoint < Point
    attr_accessor :z

    def initialize(x, y, z)
            super(x, y)
            @z = z
    end
    def dist_from_origin
        d = super
        Math.sqrt(d * d + @z * @z)
    end
    def dist_from_origin2
        d = super
        Math.sqrt(d * d + z * z)
    end
end

# Here, the code-reuse advantage is limited to inheriting methods x, x=, y, 
# and y=, as well as using other methods in Point via super. Notice that in 
# addition to overriding initialize, we used overriding for distFromOrigin 
# and distFromOrigin2.

# Polar coordinate system is a two-dimensional coordinate system in which 
# each point on a plane is determined by a distance from a reference point 
# and an angle from a reference direction.

class PolarPoint < Point
    def initialize(r, theta)
        @r = r
        @theta = theta
    end
    def x
        @r * Math.cos(@theta)
    end
    def y
        @r * Math.sin(@theta)
    end
    def x= a
        b = y
        @theta = Math.atan(b/ a)
        @r = Math.sqrt(a * a + b * b)
        self
    end
    def y= b
        a = y
        @theta = Math.atan(b / a)
        @r = Math.sqrt(a*a + b*b)
        self
    end
    def distFromOrigin
        @r
    end
end

# Notice instances of PolarPoint do not have instance variables @x and 
# @y, but the class does override the x, x=, y, and y= methods so that 
# clients cannot tell the implementation is different.

# The key point of this example is that the subclass does not override 
# distFromOrigin2, but the inherited method works correctly.

## DYNAMIC DISPATCH

# The variable-lookup rules for local variables in methods and blocks are 
# not too different from in ML and Racket despite some strangeness from 
# variables not being declared before they are used.

# In any environment, self maps to some object, which we think of as the 
# “current object” — the object currently executing a method. To look up 
# an instance variable @x, we use the object bound to self – each object
#  has its own state and we use self’s state. To look up a class variable 
# @@x, we just use the state of the object bound to self.class instead.

# RULE FOR EVALUATING e0.m(e1..,..,en)

# Evaluate e0, e1, ..., en to values: objects obj0, obj1, ..., objn.
# Get the class of obj0. Every object “knows its class” at run-time. 
# Think of the class as part of the state of obj0.
# Suppose obj0 has class A. If m is defined in A, call that method. 
# Otherwise recur with the superclass of A to see if it defines m. 
# Raise a “method missing” error if neither A nor any of its superclasses 
# define m.
# We have now found the method to call. If the method has formal arguments 
# (i.e., argument names or parameters) x1, x2, . . . , xn, then the environment 
# for evaluating the body will map x1 to obj1, x2 to obj2, etc. But there 
# is one more thing that is the essence of object-oriented programming and
# has no real analogue in functional programming: We always have self in the 
# environment. While evaluating the method body, self is bound to obj0, the 
# object that is the “receiver” of the message.