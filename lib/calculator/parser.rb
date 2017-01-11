class Calculator::Parser

	def self.parse token_array
		detect_expression token_array
	end

	def self.detect_priority_3 token_array
		# prioridade 3 podem ser da forma: {prior2}, prior2
		raise "Unexpected Ending" if token_array.empty?
		
		if token_array[0].type == :open_key
			token_array.shift
			value = detect_priority_2 token_array
			raise "Semantic Error" if token_array.shift.type != :close_key
			return value
		end

		detect_priority_2 token_array
	end

	def self.detect_priority_2 token_array
		# prioridade 2 podem ser da forma: [prior1], prior1
		raise "Unexpected Ending" if token_array.empty?
		
		if token_array[0].type == :open_bracket
			token_array.shift
			value = detect_priority_1 token_array
			raise "Semantic Error" if token_array.shift.type != :close_bracket
			return value
		end

		detect_priority_1 token_array
	end

	def self.detect_priority_1 token_array
		# prioridade 1 podem ser da forma: (expr), expr
		raise "Unexpected Ending" if token_array.empty?
		
		if token_array[0].type == :open_parenthesis
			token_array.shift
			value = detect_expression token_array
			raise "Semantic Error" if token_array.shift.type != :close_parenthesis
			return value
		end

		detect_expression token_array
	end

	def self.detect_expression token_array
		# expressões podem ser da forma: term (PLUS|MINUS expr)*, term
		raise "Unexpected Ending" if token_array.empty?
		value = detect_term token_array

		if token_array.empty?
			return value
		end

		next_token = token_array.shift

		if next_token.type == :plus
			return value + detect_expression(token_array)
		end

		if next_token.type == :minus
			return value - detect_expression(token_array)
		end

		token_array.unshift next_token
		value
	end

	def self.detect_term token_array
		# termos podem ser da forma: factor ((MULT|DIV) factor)*
		raise "Unexpected Ending" if token_array.empty?
		value = detect_factor token_array

		if token_array.empty?
			return value
		end
		
		next_token = token_array.shift

		if next_token.type == :mult
			return value * detect_factor(token_array)
		end

		if next_token.type == :div
			return value / detect_factor(token_array)
		end

		token_array.unshift next_token
		value
	end

	def self.detect_factor token_array
		# fatores podem ser da forma: NUMBER, pr3
		raise "Unexpected Ending" if token_array.empty?
		return token_array.shift.value if token_array[0].type == :number
		detect_priority_3 token_array
	end
end
