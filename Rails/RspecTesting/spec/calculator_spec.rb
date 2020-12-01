require_relative '../calculator.rb'
require 'rspec'

describe Calculator do
    before { @calculator = Calculator.new }

    it 'should add two numbers correctly' do
        expect(@calculator.add(2, 2)).to eq 4
    end

    it 'should subtact two numbers correctly' do
        expect(@calculator.sub(10, 5)).to eq 5
    end

    it 'should multiply two numbers correctly' do
        expect(@calculator.mul(1, 1)).to eq 1
    end

    it 'should divide two numbers correctly' do
        expect(@calculator.div(10, 2)).to eq 5
    end
end