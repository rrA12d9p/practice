class Station
	attr_accessor :name, :lines, :connected, :lat, :lng
	attr_accessor :orange_pos, :blue_pos, :red_pos, :green_pos, :yellow_pos, :silver_pos

	def initialize(name)
		@name = name
		@lines = []
		@connected = []
		
		@orange_pos = 0
		@blue_pos = 0
		@red_pos = 0
		@green_pos = 0
		@yellow_pos = 0
		@silver_pos = 0
	end

	def is_connected_to?(station)
		return connected.include?(station)
	end

	def closest_connection_to(dest)
		distances = self.connected.map {|c| c.distance_to(dest)}
		c_index = distances.index(distances.min)

		return self.connected[c_index]
	end

	def add_line(line)
		@lines << line
	end

	def add_connected(stop)
		@connected << stop
		@connected.uniq!
	end

	def line_names
		return @lines.map {|line| line.name}
	end

	def transfer_station?
		return @lines.length > 1
	end

	def same_line?(stop)
		common_lines = @lines & stop.lines
		return common_lines == nil ? false : common_lines.length > 0
	end

end