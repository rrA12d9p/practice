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
		@stop << stop
	end

	def stop_by_name(stop_name)
		all_stop_names = @stops.map {|stop| stop.name}
		index = all_stop_names.index(stop_name)
		return @stops[index]
	end

	# remove a line object from our lines array
	def remove_line(line)
		@lines.delete(line)
	end
end