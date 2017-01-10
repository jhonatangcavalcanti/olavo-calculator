require "spec_helper"

describe Calculator::Parser do
	it "detecta um fator" do
		expect(Calculator::Parser.detect_factor([Calculator::Token.new(:number, 98.34)], 0)).to be 98.34
	end

	it "detecta um termo" do
		expect(Calculator::Parser.detect_term([Calculator::Token.new(:number, 2), Calculator::Token.new(:plus, :'+'), Calculator::Token.new(:number, 3)])).to eq(5)
	end

end
