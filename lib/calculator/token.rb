class Calculator::Token
	attr_accessor :type, :value

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

	def initialize type, value
		@type = name
		@value = value
	end

end
