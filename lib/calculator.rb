require "calculator/version"
require "calculator/token"
require "calculator/lexer"
require "calculator/parser"

module Calculator
	def self.solve string
		token_array = Lexer.tokenize string
		Parser.parse token_array
	end
end
