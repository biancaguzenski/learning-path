# this is a comment
# Ruby is a dinamically-typed pure OO language.
# Ruby is a good choice for part C because  all the values are objects and that help us understand OO.
# Ruby is very dynamic and has semantics of a script language

class Hello # class determinates object's behavior
    def hello # methods of classes are messages to the objects
        puts "Hello, World" # methods belong to objects
    end
end

hello = Hello.new # each object is an instance of a class
# hello.hello

class A
    def m1
        34
    end

    def m2(x, y)
        z = 7
        if x > y then false else x + y * z
        end
    end
end  

class B
    def m1
        4
    end
    def m3(x)
        x.abs * 2 + self.m1 #self = myself, this object
    end
end

# e.m() to call the method over the object

class C
    def m1
        print "hi"
        self
    end
    def m2
        print "ok"
        self
    end
    def m3
        print "bye"
        self
    end
end

class D
    def initialize(f=0) # initialize is a method that is always called when you create an instance of the class
        @foo = f
    end
    def m1
        @foo = 0
    end
    def m2(x)
        @foo += x
        @bar = 0
    end
    def foo
        @foo
    end
end

class E
    Age = 38
    def self.reset_bar
        @@bar = 0
    end
    def initialize(f=0)
        @foo = f
    end
    def m1(x)
        @foo += x
        @@bar += 1
    end
    def foo
        @foo
    end
    def bar
        @@bar
    end
end