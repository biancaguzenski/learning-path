def using_yield x
    if x > 10
        yield
    else
        yield 5
        yield
    end
end
using_yield(10) { |x| puts "yes #{x}" }

public 

def my_map 
    arr = []

    self.each do |el|
        arr << yield(el)
    end
    arr
end

arry = [1, 2, 3]
res = arry.my_map { |n| n * 2 }
print res
