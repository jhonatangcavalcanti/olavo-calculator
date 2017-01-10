class Calculator::Lexer

	@@tokens = {	
		:'[' => :open_bracket,
		:'(' => :open_parenthesis,
		:'{' => :open_key,
		:']' => :close_bracket,
		:')' => :close_parenthesis,
		:'}' => :close_key,
		:'+' => :plus,
		:'-' => :minus,
		:'*' => :mult,
		:'/' => :div
	}

	def self.tokenize string
		tokens = []
		last_token = nil
		i = 0

		while i < string.length do
			i = detect_token string, i, tokens
		end

		tokens
	end

	def self.detect_token string, index, tokens
		current = string[index]

		if current =~ /\s/
			return index + 1
		end
		
		if current =~ /\d/ || (current =~ /-/ && (index + 1) < string.length && string[index + 1] =~ /\d/)
			return detect_number string, index, tokens
		end

		if @@tokens.keys.include? current.to_sym
			tokens << Calculator::Token.new(@@tokens[current.to_sym], current.to_sym)
			return index + 1
		end

		raise "Syntax Error"
	end

	def self.detect_number string, index, tokens
		number = string[index]

		index = get_number number, string, index + 1

		if index + 1 < string.length && string[index] =~ /\./ && string[index + 1] =~ /\d/
			number << '.'
			index = get_number number, string, index + 1
		end

		tokens << Calculator::Token.new(:number, number.to_f)

		index
	end

	def self.get_number number, string, index
		while index < string.length && string[index] =~ /\d/ do
			number << string[index]
			index += 1
		end

		index
	end
end
