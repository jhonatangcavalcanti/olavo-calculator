class OlavoCalculator::Parser

	PRIORITY_SEMANTICS = {
		:open_parenthesis	=> :close_parenthesis,
		:open_bracket		=> :close_bracket,
		:open_key			=> :close_key
	}

	def parse token_array
    @token_array = token_array
		detect_expression
	end

	# expressões podem ser da forma: priority (PLUS|MINUS expr)*, term
  private
  def detect_expression
		raise OlavoException, "Unexpected Ending" if @token_array.empty?
		value = detect_priority

		return value if @token_array.empty?

		next_token = @token_array.shift

		while next_token && [:plus, :minus].include?(next_token.type) do
			value += detect_term if next_token.type == :plus
			value -= detect_term if next_token.type == :minus
			next_token = @token_array.shift
		end

		@token_array.unshift next_token
		@token_array.unshift OlavoCalculator::Token.new(:number, value)

		detect_term
	end

	# prioridades podem ser da forma: (expr), [expr], {expr}, term
	def detect_priority
		raise OlavoException, "Unexpected Ending" if @token_array.empty?
		
		if PRIORITY_SEMANTICS.key? @token_array[0].type
			priority = @token_array.shift
			value = detect_expression
			raise OlavoException, "Semantic Error" unless @token_array.shift.type == PRIORITY_SEMANTICS[priority.type]
			return value
		end

		detect_term
	end

	# termos podem ser da forma: factor ((MULT|DIV) factor)*
	def detect_term
		raise OlavoException, "Unexpected Ending" if @token_array.empty?
		value = detect_factor

		return value if @token_array.empty?
		
		next_token = @token_array.shift

		while next_token && [:mult, :div].include?(next_token.type) do
			value *= detect_factor if next_token.type == :mult
			value /= detect_factor if next_token.type == :div
			next_token = @token_array.shift
		end

		@token_array.unshift next_token unless next_token.nil?

		value
	end

	# fatores podem ser da forma: NUMBER, priority
	def detect_factor
		raise OlavoException, "Unexpected Ending" if @token_array.empty?
		return @token_array.shift.value if @token_array[0].type == :number
		detect_priority
	end
end
