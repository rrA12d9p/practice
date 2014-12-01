class Trip
	attr_reader :orig, :dest, :visited_stops, :final_path, :successful_paths

	def initialize(orig, dest)
		@orig = orig
		@dest = dest
		@moves = []
		@successful_paths = []
	end

	# check every connection of every connection
	# if we end up at our destination, add the path we took to our successful paths array
	# don't go back to a stop in the current path

	def map_paths(orig = @orig, dest = @dest, path = [])
		path = path.dup
		path << orig

		if orig == dest
			# we made it
			# puts "did it in #{path.length-1} stops"
			@successful_paths = [path]
			return
		else
			# not there yet
			# get connections
			connections = orig.connected
			connections.each do |c|
				# skip connections in our path and move history
				next if path.include?(c)
				next if @moves.include?({from: orig, to: c})

				@moves << {from: orig, to: c}
				
				# iterate over each connection	
				map_paths(c, dest, path)
			end			
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