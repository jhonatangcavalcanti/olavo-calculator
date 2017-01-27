require 'thor'
require 'olavo_calculator'

module OlavoCalculator
	class CLI < Thor
		desc("solve EXPRESSION", "Solves the given EXPRESSION and returns the result")
		def solve expression
			puts OlavoCalculator.solve expression
    rescue OlavoException => e
      puts e.message
		end

		default_task :solve
	end
end
