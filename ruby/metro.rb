def countStops(metro, line, a, b)
	return (metro[line].index(b) - metro[line].index(a)).abs
end

def getLines(metro, stop)
	lines = []
	metro.each do |key,value|
		if value.include?(stop)
			lines << key
		end
	end
	return lines
end

def sameLine(metro, a, b)
	start_line = getLines(metro, a)
	end_line = getLines(metro, b)
	common_lines = start_line & end_line

	return !common_lines.empty?
end

def transferPoint(metro, a, b)
	if sameLine(metro, a, b)
		return -1
	end

	line_a = getLines(metro, a)[0]
	line_b = getLines(metro, b)[0]

	return -1 if line_a.empty? || line_b.empty?

	common_stops = metro[line_a] & metro[line_b]

	return common_stops.empty? ? -1 : common_stops[0]
	
end

red = ['Woodley Park', 'Dupont Circle', 'Farragut North', 'Metro Center', 'Union Station']
turquoise = ['Crystal City', 'Metro Center', 'Shaw-Howard', 'Beltwater']
orange = ['Farragut West', 'McPherson Sq', 'Metro Center', 'Federal Triangle', 'Smithsonian', "L'enfant Plaza"]

dc_metro = {}
dc_metro[:red] = red
dc_metro[:turquoise] = turquoise
dc_metro[:orange] = orange

#main
point_a = 'Woodley Park'
point_b = 'Federal Triangle'

line_a = getLines(dc_metro, point_a)[0]
line_b = getLines(dc_metro, point_b)[0]

puts "You want to go from #{point_a} to #{point_b}? (y/n)"
verify = gets.chomp.downcase

exit if verify != "y"

if sameLine(dc_metro, point_a, point_b)
	total_stops = countStops(dc_metro, line_a, point_a, point_b)
	puts "That's #{total_stops} stops away."
else
	transfer = transferPoint(dc_metro, point_a, point_b)
	puts "You're going to have to transfer from #{line_a} to #{line_b} at #{transfer}"
	leg_a_stops = countStops(dc_metro, line_a, point_a, transfer)
	leg_b_stops = countStops(dc_metro, line_b, point_b, transfer)
	puts "It's #{leg_a_stops} stop#{leg_a_stops > 1 ? "s" : ""} from #{point_a} to #{transfer} " +
		 "and #{leg_b_stops} stop#{leg_b_stops > 1 ? "s" : ""} from #{transfer} to #{point_b}"
	puts "Total stops: #{leg_a_stops + leg_b_stops}"
end

