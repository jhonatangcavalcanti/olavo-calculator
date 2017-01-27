require "olavo_calculator/version"
require "olavo_calculator/olavo_exception"
require "olavo_calculator/token"
require "olavo_calculator/lexer"
require "olavo_calculator/parser"

module OlavoCalculator
	def self.solve string
		token_array = Lexer.new.tokenize string
		Parser.parse token_array
	end
end
