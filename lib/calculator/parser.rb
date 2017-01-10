class Calculator::Parser

	def self.parse token_array
		detect_expression token_array
	end

	def self.detect_expression token_array
		# expressões podem ser da forma: (expr), [expr], {expr}, expr (PLUS|MINUS expr)*, term
		raise "Unexpected Ending" if token_array.empty?

		current = token_array.shift
		value = 0
		
		if [:open_parenthesis, :open_bracket, :open_key].include? current.type
			value = detect_expression token_array.value
			raise "Semantic Error" unless current.type == token_array.shift.type
		end

		if token_array.empty?
			token_array.unshift current
			return detect_term token_array
		end

		next_token = token_array.shift

		if next_token.type == :plus
			return detect_term(current) + detect_expression(token_array)
		end

		if next_token.type == :minus
			return detect_term().value - detect_expression(token_array).value
		end

		token_array.unshift next_token
		token_array.unshift current

		return detect_term token_array
	end

	def self.detect_term token_array
		# termos podem ser da forma: factor ((MULT|DIV) factor)*
		raise "Unexpected Ending" if token_array.empty?
		current = detect_factor token_array

		if token_array.empty?
			return current.value
		end
		
		next_token = token_array.shift

		if next_token.type == :mult
			return current.value * detect_factor(token_array).value
		end

		if next_token.type == :div
			return current.value / detect_factor(token_array).value
		end

		raise "Semantic Error"
	end

	def self.detect_factor token_array
		# fatores podem ser da forma: NUMBER
		raise "Unexpected Ending" if token_array.empty?
		current = token_array.shift
		raise "Semantic Error" unless current.type == :number
		current
	end
end
