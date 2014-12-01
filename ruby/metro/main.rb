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
  	lat = row[1].to_f
  	lng = row[2].to_f
  	orange = row[3].to_i
  	blue = row[4].to_i
  	red = row[5].to_i
  	green = row[6].to_i
  	yellow = row[7].to_i
  	silver = row[8].to_i

  	lines = []

  	new_station = Station.new(name, lat, lng)

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

# dc_metro.lines.each do |line|
# 	puts "#{dc_metro.stop_by_line_pos(line, -1).name} (#{line.name})"
# end

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

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end

			when "Blue Line"

				line_pos = stop.blue_pos

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end

			when "Red Line"

				line_pos = stop.red_pos

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end

			when "Green Line"

				line_pos = stop.green_pos

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end

			when "Yellow Line"

				line_pos = stop.yellow_pos

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end

			when "Silver Line"

				line_pos = stop.silver_pos

				if !first && !last
					stop.connected << line.stops[i-1] # add previous station
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}, After: #{line.stops[i+1].name}"
				elsif first
					stop.connected << line.stops[i+1] # add next station
					# puts "Station: #{stop.name}, After: #{line.stops[i+1].name}"
				elsif last
					stop.connected << line.stops[i-1] # add previous station
					# puts "Station: #{stop.name}, Before: #{line.stops[i-1].name}"
				end
		end
	end
end

orig = dc_metro.stop_by_name("West Falls Church")
dest = dc_metro.stop_by_name("Judiciary Sq")

trip = Trip.new(orig, dest)

trip.map_paths
trip.successful_paths.each do |path|
	path_names = path.map {|station| station.name}
	p path_names
end

exit
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
