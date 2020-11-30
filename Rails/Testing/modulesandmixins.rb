# Modules are containters - it is like a class  but cant be instantiated

# modules as namespace - so classes wont colide if they have the same names

module Sports
    class Match
        attr_accessor :score
    end
end

module Patterns
    class Match
        attr_accessor :complete
    end
end

match1 = Sports::Match.new     # :: operator
match1.score = 45
puts match1.score

# modules as mixins - share code among multiple classes

module SayMyName
    attr_accessor :name

    def print_name
        print @name
    end
end

class Person
    include SayMyName
end

class Company
    include SayMyName
end

person = Person.new
person.name = "Joanna"
person.print_name
company = Company.new
company.name = "Frex CO."
company.print_name

# Enumerable module: contains map, select, reject etc

class Team
    include Enumerable

    attr_accessor :name, :players
    def initialize(name)
        @name = name
        @players = []
    end
    def add_players(*players)
        @players += players
    end
    def each
        @players.each { |player| yield player }    # to use select, reject etc
    end
end
