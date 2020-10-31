# Subclassing is an essential feature of class-based OOP. If class C is a subclass of D, 
# then every instance of C is also an instance of D. The definition of C inherits the 
# methods of D, i.e., they are part of C’s definition too. Moreover, C can extend by 
# defining new methods that C has and D does not. And it can override methods, by 
# changing their definition from the inherited definition.

# Every class has a superclass. 
# Every object also has methods is_a? and instance_of?.
# The method is_a? takes a class (x.is_a? Integer) and returns true if the receiver 
# is an instance of Integer or any (transitive) subclass of Integer, i.e., if it is 
# below Integer in the class hierarchy. The method instance_of? is similar but
# returns true only if the receiver is an instance of the class exactly, not a subclass.

# Here are definitions for simple classes that describe simple two-dimensional points and a 
# subclass that adds a color (just represented with a string) to instances.

class Point
    attr_accessor :x, :y # made instance vars mutable

    def initialize(x, y)
        @x = x
        @y = y
    end
    def dist_from_origin # this method access instance variables directly
        Math.sqrt(@x * @x + @y * @y)
    end
    def dist_from_origin2 # this method getter method on self
        Math.sqrt(x * x + y * y)
    end
end

class ColorPoint < Point
    attr_accessor :color

    def initialize(x, y, c="clear") # default color is clear
        super(x, y) # allows an overriding method to call the method of the same name in the superclass
        @color = c
    end
end

#  Defining ColorPoint is good style because it allows us to reuse much of 
# our work from Point and it makes sense to treat any instance of ColorPoint 
# as though it “is a” Point.

# ALTERNATIVES TO SUBCLASS

# 1) extend and modify with new methods ( we could change the Point class by 
# replacing its initialize method and adding getter/setter methods for @color.)
# This is an alternative only if every Point object, should have a color or at 
# least having a color would not mess up anything else in our program.
# 2) We could just define ColorPoint “from scratch,” copying over (or retyping) 
# the code from Point. One advantage of not subclassing Point is that any later 
# changes to Point will not affect ColorPoint
# 3) We could have ColorPoint be a subclass of Object but have it contain an 
# instance variable, call it @pt, holding an instance of Point. Then it would
# need to define all of the methods defined in Point to forward the message to 
# the object in @pt.

def i_nitialize(x,y,c="clear") # BAD STYLE
    @pt = Point.new(x,y)
    @color = c
end
def x
    @pt.x # forward the message to the object in @pt
end