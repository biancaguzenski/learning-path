# Ruby mostly do not use loops: it uses methods that take blocks. This blocks are almost closures.

3.times { puts "hi" } # Time is a integer method. Block is given inside {}.

# Blocks are closures in the sense that they can refer to variables in scope where the block is defined.

y = 7
[4, 6, 8].each { y+= 1 } # Each is an array iterator

# Blocks are not objects - You cant pass them as regular arguments to methods.
# Any method can have either 0 or 1 block, separated to other arguments. 

sum = [1, 2, 3].inject(0) { |acc, sum| acc + sum} # Inject is like fold = accumulator is the sum until now
puts sum

# You can define your own method that takes a block! Use the keyword yield to call the block inside a method.

def foo(x)
    if x
        yield
    else
        yield
        yield
    end
end
foo(true) { puts "hi!" } # An error will result if yield is used and no block was passed.
foo(false) { puts "bye" }

class F
    def initialize(max)
        @max = max
    end
    def silly()
        yield(4, 5) + yield(@max, @max)
    end
    def count(base)
        if base > @max
            raise "reached max"
        elsif yield base
            1
        else
            1 + (count(base+1) { |i| yield i})
        end
    end
end
