require 'thor'
require 'calculator'

module Calculator
	class CLI < Thor
		desc("solve EXPRESSION", "Solves the given EXPRESSION and returns the result")
		def solve expression
			puts Calculator.solve expression
		end

		default_task :solve
	end
end
