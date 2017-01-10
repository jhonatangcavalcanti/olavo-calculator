require "spec_helper"

describe Calculator::Lexer do
	it "realiza a tokenização da string" do
		expect(Calculator::Lexer.tokenize('{[123.4) + 3 -*/} ]').map { |token| token.type }).to match_array [:open_key, :open_bracket, :number, :close_parenthesis, :plus, :number, :minus, :mult, :div, :close_key, :close_bracket]
	end

	it "retorna um erro de sintaxe na tokenização da string" do
		expect { Calculator::Lexer.tokenize('{ []62k{') }.to raise_error("Syntax Error")
	end
end
