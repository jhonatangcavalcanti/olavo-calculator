require "spec_helper"

describe Calculator::Parser do
	describe '#detect_factor' do
		it "recognizes factor '98.34'" do
			expect(Calculator::Parser.detect_factor([Calculator::Token.new(:number, 98.34)])).to be 98.34
		end
	end

	describe '#detect_term' do
		it "recognizes term '2*3'" do
			expect(Calculator::Parser.detect_term([Calculator::Token.new(:number, 2), Calculator::Token.new(:mult, :'*'), Calculator::Token.new(:number, 3)])).to eq 6
		end
	end

	describe '#detec_expression' do
		it "recognizes expression '2+3'" do
			expect(Calculator::Parser.detect_expression([Calculator::Token.new(:number, 2), Calculator::Token.new(:plus, :'+'), Calculator::Token.new(:number, 3)])).to eq 5
		end
	end
end
