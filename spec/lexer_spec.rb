require "spec_helper"

describe OlavoCalculator::Lexer do
	describe '#tokenize' do
		it 'tokenization of the string "{[123.4) + 3 -*/} ]"' do
			expect(OlavoCalculator::Lexer.tokenize('{[123.4) + 3 -*/} ]').map { |token| token.type }).to match_array [:open_key, :open_bracket, :number, :close_parenthesis, :plus, :number, :minus, :mult, :div, :close_key, :close_bracket]
		end

		it 'raise a syntax error caused by "{ []62k{"' do
			expect { OlavoCalculator::Lexer.tokenize('{ []62k{') }.to raise_error("Syntax Error")
		end
	end
end
