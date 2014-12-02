class Trip
	attr_reader :orig, :dest, :successful_paths

	def initialize(orig, dest)
		@orig = orig
		@dest = dest
		@successful_paths = []
	end

	def min_path_length
		path_stop_lengths = @successful_paths.map {|path| path.length}
		return path_stop_lengths.min
	end

	# check every connection of every connection
	# if we end up at our destination, add the path we took to our successful paths array
	# don't go back to a stop in the current path
	def map_paths(orig = @orig, dest = @dest, path = [])

		# we have to duplicate each path array to its own object
		# to ensure it isn't contaminated by another iteration
		path = path.dup
		path << orig

		if orig == dest
			if !@successful_paths.include?(path)
				@successful_paths << path
				return
			end
		else
			# get connections
			connections = orig.connected
			# remove previous stops from possible connections list
			connections = connections - path
			connections.each do |c|

			map_paths(c, dest, path)
			end
		end
	end
end