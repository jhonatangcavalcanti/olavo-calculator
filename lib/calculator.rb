require_relative "./calculator/version"
require_relative "./calculator/token"
require_relative "./calculator/lexer"
require_relative "./calculator/parser"

module Calculator
	def self.solve string
		token_array = Lexer.tokenize string
		Parser.parse token_array
	end
end
