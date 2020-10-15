## PROCS

# Blocks are not quite closures because they are not objects. We cant store them or put them in an array.
# Blocks are not first-class values.
# Proc is the real closure in ruby. You use the method call to apply the closures to arguments.
# To make a Proc out of a block, you can write lambda { ... } where { ... } is any block.
# lambda is not a keyword, it is a method that creates a proc out of a block it is passed.

# Suppose we wanted to create an array of blocks, i.e., an array where each element was something we
# could “call” with a value. You can do this with a proc:

a = [1, 2, 3]
c = a.map { |x| lambda { |y| x >= y} }
puts c
puts c[2].call 7 # send a call to element 2 in c and pass 7 as argument. x becomes 3 and y is 7.
j = c.count {|x| x.call(1) }
puts j

# Blocks are more convenient to use than Proc objects and suffice in most uses, but programmers 
# still have Proc objects when needed.


## OTHER COLLECTIONS - HASHES AND RANGES

# These are two classes similar to arrays and support many of the same iterator methods.
# A hash is like an array except the mapping is not from numeric indices to objects. Instead, the mapping is
# from (any) objects to objects.

hash = {:SML => 1, :Racket => 2, :Ruby => 3}
# Access to value is via key - hash[:SML] or with methods

puts hash[:SML]
print hash.values
print hash.keys

# A range represents a contiguous sequence of numbers (or other things, but we will focus on numbers).

arr = Array.new(10) { |i| i }
print arr

(0..10).each  { |i| print i }
