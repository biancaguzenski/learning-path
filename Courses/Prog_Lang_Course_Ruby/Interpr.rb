# OOP vs Functional Decomposition - Ruby X ML

class Exp
end

class Values < Exp
end

class Int < Values
    attr_reader :i

    def initialize(i)
        @i = i
    end
    def eval
        self
    end
    def to_string
        @i.to_s
    end
    def hasZero
        i==0
    end
end

class Negate < Int
    attr_reader :e
    def initialize(e)
        @e = e
    end

    def eval
        Int.new(-e.eval.i)
    end
    def to_string
        "-(" + e.to_string + ")"
    end
    def hasZero
        e.hasZero
    end
end

class Add
    attr_reader :e1, :e2
    def initialize(e1, e2)
        @e1 = e1
        @e2 = e2
    end
    def eval
        Int.new(e1.eval.i + e2.eval.i)
    end
    def to_string
        "(" + e1.to_string + "+" + e2.to_string + ")"
    end
    def hasZero
        e1.hasZero || e2.hasZero
    end
end

# To insert rational values to this, we must consider adding int to rational, string to rational and so forth.
# That means we have to handle all the cases. We could do as follows, but this is not pure OOP, this is func
# tional programming with ruby.
# In FP, adding a new operation is easy: we can implement a new function without editing any existing code.
# functional decomposition allows new operations and object-oriented decomposition allows new variants without 
# existing code and without explicitly planning for it.

# It seems clear that if you expect new operations, then a functional approach is more natural and if you
# expect new data variants, then an object-oriented approach is more natural. The problems are (1) the future
# is often difficult to predict; we may not know what extensions are likely, and (2) both forms of extension
# may be likely. Languages like Scala aim to support both forms of extension well; we are still gaining
# practical experience on how well it works as it is a fundamentally difficult issue


# class Int
#  def add_values v
#   if v.is_a? Int
#       Int.new(v.i + i)
#   elsif v.is_a? MyRational
#       MyRational.new(v.i+v.j*i, v.j)
#   else
#       MyString.new(v.s + i.to_s)
#   end
#  end
# end