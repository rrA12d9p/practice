class Metro
	attr_reader :name, :lines, :stops

	def initialize(name)
		@name = name
		@lines = []
		@stops = []
	end

	# add a line object to our lines array
	def add_line(line)
		@lines << line
	end

	def add_stop(stop)
		@stops << stop
	end

	def stop_by_line_pos(line_obj, pos)
		stop_obj = lines.select {|line| line == line_obj}[0].stops[pos]
		return stop_obj
	end

	def stop_by_name(stop_name)
		all_stop_names = @stops.map {|stop| stop.name}
		index = all_stop_names.index(stop_name)
		return nil if index == nil

		return @stops[index]
	end

	def line_by_name(line_name)
		return @lines.select {|line| line.name == line_name}
	end

	# remove a line object from our lines array
	def remove_line(line)
		@lines.delete(line)
	end
end