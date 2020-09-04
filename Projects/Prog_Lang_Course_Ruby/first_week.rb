# this is a comment
# Ruby is a dinamically-typed pure oo language.
# Ruby is a good choice for part C because  all the values are objects and that help us understand oo.
# Ruby is very dynamic and has semantics of a script language

class Hello # class determinates object's behavior
    def hello # methods of classes are messages to the objects
        puts "Hello, World" # methods belong to objects
    end
end

hello = Hello.new # each object is an instance of a class
hello.hello