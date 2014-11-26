require_relative 'metro.rb'
require_relative 'line.rb'
require_relative 'stop.rb'

# model	->
red_line = Line.new("Red Line", ['Woodley Park', 'Trey Station', 'Dupont Circle', 'Random Transfer', 'Farragut North', 'Metro Center', 'Union Station'])
turquoise_line = Line.new("Turquoise Line", ['Crystal City', 'Random Transfer', 'Metro Center', 'Trey Station', 'Shaw-Howard', 'Beltwater'])
orange_line = Line.new("Orange Line", ['Farragut West', 'McPherson Sq', 'Metro Center', 'Trey Station', 'Federal Triangle', 'Smithsonian', "L'enfant Plaza"])

metro_lines = [red_line, turquoise_line, orange_line]

dc_metro = Metro.new("DC Metro")

metro_lines.each do |line|

	dc_metro.add_line(line)

	line.stops.each_with_index do |stop_name, position|
		created_stop_names = dc_metro.stops.map {|stop| stop.name}
		stop_position = line.stops.index(stop_name)

		if created_stop_names.include?(stop_name)
			# this stop already created/tagged by another metro line; need to tag it with this metro line too
			i = created_stop_names.index(stop_name)
			stop = dc_metro.stops[i]
			stop.add_line(line)
		else
			# this stop doesn't exist yet; need to create/tag it
			stop = Stop.new(stop_name)
			stop.add_line(line)
			dc_metro.stops << stop
		end
	end
end

# loop through line stops
# look up object by name
# add adjacent stops
metro_lines.each do |line|
	line.stops.each_with_index do |stop_name, position|
		stop = dc_metro.stop_by_name(stop_name)
		if position != 0
			left = dc_metro.stop_by_name(line.stops[position-1])
			stop.add_connected(left)
		end
		if position != line.stops.length - 1
			right = dc_metro.stop_by_name(line.stops[position+1])		
			stop.add_connected(right)
		end
	end
end

# model <-

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

# Main
while 1
	all_stop_names = dc_metro.stops.map { |stop| stop.name}.sort
	puts "Origin:"
	point_a_name = list_options(all_stop_names)[1]
	
	puts "Destination:"
	possible_destinations = all_stop_names.select {|stop| stop != point_a_name}
	point_b_name = list_options(possible_destinations.sort)[1]
	
	puts "You want to go from #{point_a_name} to #{point_b_name}? (y/n)"
	if gets.chomp.downcase != "y"
		puts "Try again?"
		gets.chomp.downcase == "y" ? next : exit
	end

	point_a = dc_metro.stop_by_name(point_a_name)
	point_b = dc_metro.stop_by_name(point_b_name)

	stops = point_a.stops_to(dc_metro, point_b)

	puts "Total stops: #{stops}"

	puts "Again? (y/n)"
	gets.chomp.downcase == "y" ? next : exit
end
