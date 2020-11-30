# methods and classes begin new scope for variables

v1 = "outside"

class AClass
    def a_method
        v1 = "inside"
        p v1
        p local_variables # returns array of symbols
    end
end
p "v1 is #{v1}"
obj = AClass.new
obj.a_method
p local_variables  # returns v1 and obj
p self

# constants scope are different

module Test
    PI = 3.14
    class Test2
        def what_is_pi
            puts PI
        end
    end
end
Test::Test2.new.what_is_pi
# you can override the constant inside another scope, but it doesnt change the outside scope

# Block inherits outside scope - they are closures: remembers the context in which is defined and uses thet context

class BankAccount
    attr_accessor :id, :amount

    def initialize(id, amount)
        @id = id
        @amount = amount
    end
end

acct1 = BankAccount.new(123, 200)
acct2 = BankAccount.new(456, 300)
accts = [acct1, acct2]

total_sum = 0
accts.each do |acct|
    total_sum += acct.amount
end
puts total_sum

