require 'token'

class Calculator::Lexer

	def tokenize string
		tokens = []
		last_token = nil

		string.each_char do |char|
			case char
			when /\d/ then nil
			when /\s/ then 'blank'
			when '[', ']', '(', ')', '{', '}', '+', '-', '*', '/' then puts 'reserved'
			else raise 'Syntax Error'
			end
		end

		tokens
	end
end
