require "spec_helper"

describe OlavoCalculator::Parser do
	describe '#parser' do
		it "recognizes expression '2+3'" do
			expect(OlavoCalculator::Parser.new.parse([OlavoCalculator::Token.new(:number, 2), OlavoCalculator::Token.new(:plus, :'+'), OlavoCalculator::Token.new(:number, 3)])).to eq 5
		end
	end
end
