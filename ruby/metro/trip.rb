class Trip
	attr_reader :orig, :dest, :successful_paths, :num_paths

	def initialize(orig, dest)
		@orig = orig
		@dest = dest
		@moves = []
		@dead_ends = []
		@successful_paths = []
		@num_paths = 0
		@min_path_length = 15
	end

	def min_path_length
		path_stop_lengths = @successful_paths.map {|path| path.length}
		return path_stop_lengths.min
	end

	# check every connection of every connection
	# if we end up at our destination, add the path we took to our successful paths array
	# don't go back to a stop in the current path
	def map_paths(orig = @orig, dest = @dest, path = [], last_transfer = {})
		# we have to duplicate each path array to its own object
		# to ensure it isn't contaminated by another iteration
		path = path.dup
		path << orig

		p path.map {|path| path.name}

		if orig == dest
			if !@successful_paths.include?(path)
				@successful_paths << path
				@min_path_length = min_path_length
				return
			end
		else
			# get connections
			connections = orig.connected

			connections.each do |c|

				# update last_transfer if we're leaving a transfer hub
				if connections.length > 2
					last_transfer = {from: orig, to: c}
				end 

				# we're at a dead end
				if connections.length == 1 && path.include?(c)
					# add the last_transfer to @dead_ends
					if last_transfer.length > 0
						# puts "Dead end from #{last_transfer[:from].name} to #{last_transfer[:to].name}"
						# puts "Avoiding #{last_transfer}"
						@dead_ends << last_transfer
					else
						# puts "Hit dead end at #{orig.name}. No previous transfers."
					end
				end

				# skip connections in our path and move history
				next if path.include?(c)

				# skip connections marked as leading to dead ends
				if @dead_ends.include?({from: orig, to: c})
					# puts "skipping #{orig.name} -> #{c.name}"
					next 
				end

				# don't evaluate routes involving station's we've evaluated before
				# we have to do this to limit the paths generated
				if @moves.include?({from: orig, to: c})
					# allow paths to repeat initial stops
					next if path.length > [@min_path_length, 10].min
				end

				@moves << {from: orig, to: c}
				@num_paths += 1
				map_paths(c, dest, path, last_transfer)
			end			
		end
	end
end