class Person
    attr_accessor :first_name, :last_name

    @@people = []

    def initialize(first_name, last_name)
        @first_name = first_name
        @last_name = last_name
        @@people.push self
    end

    def self.search(last)
        match = []
        @@people.each do |person|
            if person.last_name == last
                match.push person.to_s
            end
        end
        match
    end

    def to_s
        "#{first_name} #{last_name}"
    end
end

p1 = Person.new("John", "Smith")
p2 = Person.new("John", "Doe")
p3 = Person.new("Jane", "Smith")
p4 = Person.new("Cool", "Dude")

puts Person.search("Smith")