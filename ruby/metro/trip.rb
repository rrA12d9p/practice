class Trip
	attr_reader :orig, :dest, :successful_paths

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
		# we have to duplicate each path array to its own object
		# to ensure it isn't contaminated by another iteration
		path = path.dup
		path << orig

		if orig == dest
			if !@successful_paths.include?(path)
				@successful_paths << path
			end
		else
			# get connections
			connections = orig.connected
			connections.each do |c|
				# skip connections in our path and move history
				next if path.include?(c)

				# don't evaluate routes involving station's we've evaluated before
				# we have to do this to limit the paths generated
				if @moves.include?({from: orig, to: c})
					# allow paths to repeat initial stops
					next unless path.length < 5
				end

				@moves << {from: orig, to: c}
				map_paths(c, dest, path)
			end			
		end
	end
end