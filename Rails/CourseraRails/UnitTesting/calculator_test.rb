require 'test/unit'
require_relative 'calculator'

class CalculatorTest < Test::Unit::TestCase
   
    def test_divide_zero
        assert_raise ZeroDivisionError do
            Calculator.new.div(1/0)
        end
    end
    def test_add
        assert_equal 5, Calculator.new.add(2, 3)
    end

    def test_sub
        assert_equal 1, Calculator.new.sub(2, 1)
    end

    def test_mul
        assert_equal 100, Calculator.new.mul(10, 10)
    end
    
    def test_div
        assert_equal 2, Calculator.new.div(10, 5)
    end
end