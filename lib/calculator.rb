require "calculator/version"
require "calculator/parser"

module Calculator
	def self.solve string
		Calculator::Parser.parse string
	end
end
