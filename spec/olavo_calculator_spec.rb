require "spec_helper"

describe OlavoCalculator do
	it "has a version number" do
		expect(OlavoCalculator::VERSION).not_to be nil
	end

	describe '#solve' do
		it "2341" do
			expect(OlavoCalculator.solve('2341')).to eq(2341.0)
		end

		it "-3513" do
			expect(OlavoCalculator.solve('-3513')).to eq(-3513)
		end

		it "-34.1532" do
			expect(OlavoCalculator.solve('-34.1532')).to eq(-34.1532)
		end

		it "3+2 = 5" do
			expect(OlavoCalculator.solve('3+2')).to eq(5)
		end 

		it '(1 + 2) = 3' do
			expect(OlavoCalculator.solve('(1 + 2)')).to eq(3)
		end

		it '([{1 + 2} + 3] + 4) + 5 = 15' do
			expect(OlavoCalculator.solve('([{1 + 2} + 3] + 4) + 5')).to eq(15)
		end

		it '12/2 + 17 - 6*2 = 11' do
			expect(OlavoCalculator.solve('12/2 + 17 - 6*2')).to eq(11)
		end

		it '3/(1+2) = 1' do
			expect(OlavoCalculator.solve('3/(1+2)')).to eq(1)
		end

		it '{4+2}*5 = 30' do
			expect(OlavoCalculator.solve('{4+2}*5')).to eq(30)
		end

		it '[10/(3+2)] = 2' do
			expect(OlavoCalculator.solve('[10/(3+2)]')).to eq(2)
		end

		it '-3*-4 = 12' do
			expect(OlavoCalculator.solve('-3*-4')).to eq(12)
		end
		
		it '4+{[3*(2+1)] + 1} = 14' do
			expect(OlavoCalculator.solve('4+{[3*(2+1)] + 1}')).to eq(14)
		end

		it 'raise a semantic error caused by {2+1)' do
			expect { OlavoCalculator.solve('{2+1)') }.to raise_error("Semantic Error")
		end
	end
end
