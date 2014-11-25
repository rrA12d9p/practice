class Line
	attr_reader :name, :stops
	def initialize(name, stops)
		@name = name
		@stops = stops
	end
end