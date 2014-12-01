class Trip
	attr_reader :orig, :dest, :successful_paths

	def initialize(orig, dest)
		@orig = orig
		@dest = dest
		@moves = []
		@successful_paths = []
		@min_path_length = 15
		# @max_path_length = 35
	end

	def min_path_length
		if @successful_paths.length == 0
			return nil
		else
			return @successful_paths.map {|path| path.length}.min
		end
	end

	# check every connection of every connection
	# if we end up at our destination, add the path we took to our successful paths array
	# don't go back to a stop in the current path

	def map_paths(orig = @orig, dest = @dest, path = [])
		# return if path.length > @max_path_length

		# we have to duplicate each path array to its own object
		# to ensure it isn't contaminated by another iteration
		path = path.dup
		path << orig

		if orig == dest
			if !@successful_paths.include?(path)
				@successful_paths << path
				if min_path_length < @min_path_length
					@min_path_length = min_path_length 
				end
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
					next unless path.length <= @min_path_length
				end

				@moves << {from: orig, to: c}
				map_paths(c, dest, path)
			end			
		end
	end
end