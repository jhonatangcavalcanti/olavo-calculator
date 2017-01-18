require "spec_helper"

describe OlavoCalculator::Parser do
	describe '#detect_factor' do
		it "recognizes factor '98.34'" do
			expect(OlavoCalculator::Parser.detect_factor([OlavoCalculator::Token.new(:number, 98.34)])).to be 98.34
		end
	end

	describe '#detect_term' do
		it "recognizes term '2*3'" do
			expect(OlavoCalculator::Parser.detect_term([OlavoCalculator::Token.new(:number, 2), OlavoCalculator::Token.new(:mult, :'*'), OlavoCalculator::Token.new(:number, 3)])).to eq 6
		end
	end

	describe '#detec_expression' do
		it "recognizes expression '2+3'" do
			expect(OlavoCalculator::Parser.detect_expression([OlavoCalculator::Token.new(:number, 2), OlavoCalculator::Token.new(:plus, :'+'), OlavoCalculator::Token.new(:number, 3)])).to eq 5
		end
	end
end
