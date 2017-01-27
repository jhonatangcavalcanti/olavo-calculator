class OlavoCalculator::Lexer

	TOKENS = {	
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

	def tokenize string
		@tokens = []
    @string = string

		last_token = nil
		i = 0

		while i < @string.length do
			i = detect_token i
		end

		@tokens
	end

  private
	def detect_token index
		current = @string[index]

    return (index + 1) if current =~ /\s/
		
    return detect_number(index) if current =~ /\d/ || negative?(index)

		if TOKENS.keys.include? current.to_sym
			@tokens << OlavoCalculator::Token.new(TOKENS[current.to_sym], current.to_sym)
			return index + 1
		end

		raise OlavoException, "Syntax Error"
	end

  def negative?(index)
    @string[index] =~ /-/ && (index + 1) < @string.length && @string[index + 1] =~ /\d/
  end

	def detect_number index
		number = @string[index]

		index = get_number number, index + 1

		if index + 1 < @string.length && @string[index] =~ /\./ && @string[index + 1] =~ /\d/
			number << '.'
			index = get_number number, index + 1
		end

		@tokens << OlavoCalculator::Token.new(:number, number.to_f)

		index
	end

	def get_number number, index
		while index < @string.length && @string[index] =~ /\d/ do
			number << @string[index]
			index += 1
		end

		index
	end
end
