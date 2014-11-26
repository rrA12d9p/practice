class Line
	attr_reader :name, :stops

	def initialize(name, stop_name_array)
		@name = name
		@stops = stop_name_array
	end

	def stop_position(stop)
		return @stops.index(stop.name)
	end

	def num_stops
		return @stops.length
	end
end