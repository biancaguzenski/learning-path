# 3 ways to define class methods

class MathFunctions
    def self.double(var)               # first way
        times_called; var*2
    end
    class << self                     # second way - define inside a class inside original class
        def times_called
            @@times_called ||= 0; @@times_called += 1           # ||= is like or operator
        end
    end
end
def MathFunctions.triple(var)                # this syntax is to define a function outside its class
   times_called; var*3
end

puts MathFunctions.double 5
# CLASS METHODS DONT NEED INSTANCES IN ORDER TO BE CALLED

# no multiple inheritance, we can use mixins

class Dog
    def to_s
        "dog"
    end
    def barks
        "WOOF"
    end
end
class SmallDog < Dog         # inheritance symbol <
    def barks            # override the barks method for smalldogs instance
        "woof"
    end
end

dog1 = Dog.new
small = SmallDog.new
puts "Big dog barks: #{dog1.barks}"
puts "Little dog barks: #{small.barks}"