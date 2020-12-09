# how much you can expose to the world?
# encapsulation
# public, protected, private

class Car
    def initialize(speed, comfort)
        @rating = speed * comfort
    end

    def rating
        @rating
    end
end
puts Car.new(4, 5).rating

class Access
    private
    def one
        "private"
    end
    protected
    def two
        "protected"
    end
    public
    def three
        "public"
    end
end

class Access2
    def private
        "private"
    end
    private :private
end

# public: anybody can call these methods
# protected: can be invoked by objects of own class
# private: cant be invoked with an explicit receiver