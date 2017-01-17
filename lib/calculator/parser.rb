class Calculator::Parser

	@@priority_semantics = {
		:open_parenthesis	=> :close_parenthesis,
		:open_bracket		=> :close_bracket,
		:open_key			=> :close_key
	}

	def self.parse token_array
		detect_expression token_array
	end

	def self.detect_priority token_array
		# prioridades podem ser da forma: (expr), [expr], {expr}, term
		raise "Unexpected Ending" if token_array.empty?
		
		if @@priority_semantics.key? token_array[0].type
			priority = token_array.shift
			value = detect_expression token_array
			raise "Semantic Error" unless token_array.shift.type == @@priority_semantics[priority.type]
			return value
		end

		detect_term token_array
	end

	def self.detect_expression token_array
		# expressões podem ser da forma: priority (PLUS|MINUS expr)*, term
		raise "Unexpected Ending" if token_array.empty?
		value = detect_priority token_array

		return value if token_array.empty?

		next_token = token_array.shift

		return (value + detect_expression(token_array)) if next_token.type == :plus

		return (value - detect_expression(token_array)) if next_token.type == :minus

		token_array.unshift next_token
		token_array.unshift Calculator::Token.new(:number, value)

		detect_term token_array
	end

	def self.detect_term token_array
		# termos podem ser da forma: factor ((MULT|DIV) factor)*
		raise "Unexpected Ending" if token_array.empty?
		value = detect_factor token_array

		return value if token_array.empty?
		
		next_token = token_array.shift

		while next_token && [:mult, :div].include?(next_token.type) do
			value *= detect_factor(token_array) if next_token.type == :mult
			value /= detect_factor(token_array) if next_token.type == :div
			next_token = token_array.shift
		end

		token_array.unshift next_token unless next_token.nil?

		value
	end

	def self.detect_factor token_array
		# fatores podem ser da forma: NUMBER, priority
		raise "Unexpected Ending" if token_array.empty?
		return token_array.shift.value if token_array[0].type == :number
		detect_priority token_array
	end
end
