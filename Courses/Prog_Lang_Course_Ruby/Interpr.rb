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