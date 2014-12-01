require 'csv'
require_relative 'metro.rb'
require_relative 'line.rb'
require_relative 'station.rb'
require_relative 'trip.rb'

# model	->
dc_metro = Metro.new("DC Metro")

CSV.read("DC_Metro_Stops.csv").each_with_index do |row, i|
		next if i == 0 # skip headers
  	name = row[0].to_s
  	orange = row[1].to_i
  	blue = row[2].to_i
  	red = row[3].to_i
  	green = row[4].to_i
  	yellow = row[5].to_i
  	silver = row[6].to_i

  	lines = []

  	new_station = Station.new(name)

  	if orange > 0
  		lines << "Orange"
  		new_station.orange_pos = orange
  	end

  	if blue > 0
  		lines << "Blue"
  		new_station.blue_pos = blue
  	end

  	if red > 0
  		lines << "Red"
  		new_station.red_pos = red
  	end

  	if green > 0
  		lines << "Green"
  		new_station.green_pos = green
  	end

  	if yellow > 0
  		lines << "Yellow"
  		new_station.yellow_pos = yellow
  	end

  	if silver > 0
  		lines << "Silver"
  		new_station.silver_pos = silver
  	end

		new_station.lines = lines
  	dc_metro.add_stop(new_station)
end

dc_metro.add_line(Line.new("Orange Line", dc_metro.stops.select {|stop| stop.lines.include?("Orange")}.sort {|a,b| a.orange_pos <=> b.orange_pos}))
dc_metro.add_line(Line.new("Blue Line", dc_metro.stops.select {|stop| stop.lines.include?("Blue")}.sort {|a,b| a.blue_pos <=> b.blue_pos}))
dc_metro.add_line(Line.new("Red Line", dc_metro.stops.select {|stop| stop.lines.include?("Red")}.sort {|a,b| a.red_pos <=> b.red_pos}))
dc_metro.add_line(Line.new("Green Line", dc_metro.stops.select {|stop| stop.lines.include?("Green")}.sort {|a,b| a.green_pos <=> b.green_pos}))
dc_metro.add_line(Line.new("Yellow Line", dc_metro.stops.select {|stop| stop.lines.include?("Yellow")}.sort {|a,b| a.yellow_pos <=> b.yellow_pos}))
dc_metro.add_line(Line.new("Silver Line", dc_metro.stops.select {|stop| stop.lines.include?("Silver")}.sort {|a,b| a.silver_pos <=> b.silver_pos}))

dc_metro.lines.each do |line|
	line.stops.each_with_index do |stop, i|
		if i == 0
			first = true
		elsif line.stops[-1] == stop
			last = true
		end

		case line.name
			when "Orange Line"
				line_pos = stop.orange_pos
			when "Blue Line"
				line_pos = stop.blue_pos
			when "Red Line"
				line_pos = stop.red_pos
			when "Green Line"
				line_pos = stop.green_pos
			when "Yellow Line"
				line_pos = stop.yellow_pos
			when "Silver Line"

				line_pos = stop.silver_pos
		end

		stop.connected << line.stops[i-1] if !first # add previous station
		stop.connected << line.stops[i+1] if !last # add next station

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
	# point_a_name = list_options(all_stop_names)[1]
	point_a_name = gets.chomp
	
	puts "Destination:"
	# possible_destinations = all_stop_names.select {|stop| stop != point_a_name}
	# point_b_name = list_options(possible_destinations.sort)[1]
	point_b_name = gets.chomp
	
	puts "You want to go from #{point_a_name} to #{point_b_name}? (y/n)"
	if gets.chomp.downcase != "y"
		puts "Try again?"
		gets.chomp.downcase == "y" ? next : exit
	end

	point_a = dc_metro.stop_by_name(point_a_name)
	point_b = dc_metro.stop_by_name(point_b_name)

	if point_a == nil || point_b == nil
		puts "Error: couldn't find #{point_a} or #{point_b}"
		exit
	elsif point_a == nil
		puts "Error: couldn't find #{point_a}"
		exit
	elsif point_b == nil
		puts "Error: couldn't find #{point_b}"
		exit
	end

	trip = Trip.new(point_a, point_b)

	trip.map_paths

	puts "Tried #{trip.num_paths} paths"

	path_stop_lengths = trip.successful_paths.map {|path| path.length}
	min_stops = path_stop_lengths.min
	min_index = path_stop_lengths.index(min_stops)
	shortest_path = trip.successful_paths[min_index]

	shortest_path_names = shortest_path.map {|station| station.name}

	# p shortest_path_names
	puts shortest_path_names

	puts "Again? (y/n)"
	gets.chomp.downcase == "y" ? next : exit
end
