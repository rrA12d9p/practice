def list_options(options)
	begin
		i = 1
		options.each do |option|
			puts "#{i}.	#{option}"
			i += 1
		end
		
		answer = gets.chomp.to_i

		if answer < 1 || answer > i - 1
			puts "Sorry, that option is unavailable."
		end
	end while answer < 1 || answer > i - 1
	return [answer, options[answer - 1]]
end

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

class Line
	attr_reader :name, :stops
	def initialize(name, stops)
		@name = name
		@stops = stops
	end
end

red_line = Line.new("Red Line", ['Woodley Park', 'Trey Station', 'Dupont Circle', 'Farragut North', 'Metro Center', 'Union Station'])
turquoise_line = Line.new("Turquoise Line", ['Crystal City', 'Metro Center', 'Trey Station', 'Shaw-Howard', 'Beltwater'])
orange_line = Line.new("Orange Line", ['Farragut West', 'McPherson Sq', 'Metro Center', 'Trey Station', 'Federal Triangle', 'Smithsonian', "L'enfant Plaza"])

dc_metro = Metro.new("DC Metro")

dc_metro.add_line(red_line)
dc_metro.add_line(turquoise_line)
dc_metro.add_line(orange_line)

# Main
while 1
	puts "Origin:"
	point_a = list_options(dc_metro.list_all_stops)
	
	puts "Destination:"
	point_b = list_options(dc_metro.list_all_stops)
	
	puts "You want to go from #{point_a[1]} to #{point_b[1]}? (y/n)"
	yn = gets.chomp.downcase
	next if yn != "y"

	puts "Point A is on lines: #{dc_metro.get_lines(point_a[1])}"
	puts "Point B is on lines: #{dc_metro.get_lines(point_b[1])}"
end
