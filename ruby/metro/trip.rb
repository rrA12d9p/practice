class Trip
	attr_reader :orig, :dest, :visited_stops, :final_path, :successful_paths

	def initialize(orig, dest)
		@orig = orig
		@dest = dest
		@visited_stops = []
		@final_path = []
		@successful_paths = []
	end

	def map_paths(orig, dest)
		puts @final_path.length
		if orig == dest
			puts "********"
			@successful_paths << @final_path
			return @final_path
		end	
		connections = orig.connected
		connections.each do |connection|
			if @visited_stops.include?(connection)
				last_try = connection == connections[-1]
				if last_try
					puts "~~~~~~" 
					@final_path = []
				end
				next #don't retry this connection
			else
				puts "#{orig.name} -> #{connection.name}"
				@visited_stops << connection
				@final_path << connection
			end
			map_paths(connection, dest)
		end
	end

	def shortest_path(orig, dest)
		if orig.distance_to(dest) > 0
			c = orig.closest_connection_to(dest)
			return if @paths.include?(c)
			# puts c.name
			@paths << c
			return shortest_path(c, dest)
		else
			return @paths
		end
	end
end