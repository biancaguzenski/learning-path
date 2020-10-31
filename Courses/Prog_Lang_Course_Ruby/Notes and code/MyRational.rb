# Ruby has a beautiful model of rational numbers, but for purposeof study we will build one of our own

class MyRational # instances of this class will represent fractions

    def initialize(num, den=1) # den = denominator
        if den == 0
            raise "You can't divide by zero"
        elsif den < 0
            @num = - num
            @den = - den
        else 
            @num = num
            @den = den
        end
        reduce() # i.e self.reduce()
    end

    def to_s() # converting rational to string
        ans = @num.to_s()
        if @den != 1
            ans += "/"
            ans += @den.to_s()
        end
        ans
    end

    def add!(r) # this is gonna mutate the object, so it is conventional to use ! in the end
        a = r.num
        b = r.den
        c = @num
        d = @den
        @num = (a * d) + (b * c)
        @den = (b * d)
        reduce()
        self
    end

    def + r
        ans = MyRational(@num, @den)
        ans.add! r
        ans
    end

    protected # the same as attr_reader

    def num
        @num
    end
    def den
        @den
    end

    private

    def gcd(x, y) # greatest common divisor
        if x == y
            x
        elsif x < y
            gcd(x, y-x)
        else
            gcd(y, x)
        end
    end

    def reduce
        if @num == 0
            @den = 1
        else
            d = gcd(@num.abs, @den)
            @num = @num / d
            @den = @den / d
        end
    end
end