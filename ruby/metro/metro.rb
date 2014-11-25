class Metro
	attr_reader :name, :lines

	def initialize(name)
		@name = name
		@lines = []
	end

	# add a line object to our lines array
	def add_line(line)
		@lines << line
	end

	# remove a line object from our lines array
	def remove_line(line)
		@lines.delete(line)
	end

	# returns an array of all lines a stop is on
	def get_lines(stop)
		lines = []
		@lines.each do |line|
			lines << line if line.stops.include?(stop)
		end
		return lines
	end

	# list all stops across all lines
	# pass false to show with duplicates
	def list_all_stops(unique = true)
		all_stops = @lines.map {|l| l.stops}.flatten.uniq
		return unique ? all_stops.uniq : all_stops
	end

	# return an array of stops that exist on multiple lines
	def all_transfer_stations
		# get all stops with repeats to determine which stops exist on multiple lines
		all_stops = list_all_stops(false)

		transfer_stations = all_stops.group_by { |e| e }.select { |k, v| v.size > 1 }.map(&:first)
		return transfer_stations
	end
end