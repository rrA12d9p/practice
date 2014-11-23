def getAllStops(metro)
	all_stops = []
	metro.each do |k,v|
		all_stops += v
	end
	return all_stops.uniq.sort
end

def listOptions(options)
	begin
		i = 1
		aOptions = options.split("|")
		aOptions.each do |option|
			puts "#{i}. #{option}"
			i += 1
		end
		
		answer = gets.chomp.to_i

		if answer < 1 || answer > i - 1
			puts "Sorry, that option is unavailable."
		end
	end while answer < 1 || answer > i - 1
	return [answer, aOptions[answer - 1]]
end

def countStops(metro, line, a, b)
	# puts "countStops: #{line}, #{a}, #{b}"
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

def transferPoints(metro, a, b)
	return [] if sameLine(metro, a, b)

	a_lines = getLines(metro, a)
	b_lines = getLines(metro, b)

	return [] if a_lines.empty? || b_lines.empty?

	common_stops = []

	a_lines.each do |a_line|
		b_lines.each do |b_line|
			puts "#{metro[a_lines]}, #{metro[b_lines]}"
		end
	end

	return common_stops.empty? ? [] : common_stops
end

def getFewestStops(metro, a, b)
	a_lines = getLines(metro, a)
	b_lines = getLines(metro, b)

	stop_counts = []
	a_lines.each_with_index do |line, i|
		b_lines.each_with_index do |line, j|

			a_line = a_lines[i]
			b_line = b_lines[j]

			# puts "getFewestStops: #{metro}, #{a}, #{b}, #{a_lines}, #{b_lines}"

			transfer_stops = transferPoints(metro, a, b)

			if sameLine(metro, a, b)
				stop_counts << countStops(metro, a_line, a, b)
			elsif transfer_stops.length >= 1
				transfer_stops.each do |transfer_stop|
					leg_a_stops = countStops(metro, a_line, a, transfer_stop)
					leg_b_stops = countStops(metro, b_line, b, transfer_stop)
					total_stops = leg_a_stops + leg_b_stops

					stop_counts << total_stops
				end
			end
		end
	end

	return stop_counts.min
end

red = ['Woodley Park', 'Trey Station', 'Dupont Circle', 'Farragut North', 'Metro Center', 'Union Station']
turquoise = ['Crystal City', 'Metro Center', 'Trey Station', 'Shaw-Howard', 'Beltwater']
orange = ['Farragut West', 'McPherson Sq', 'Metro Center', 'Trey Station', 'Federal Triangle', 'Smithsonian', "L'enfant Plaza"]

dc_metro = {}
dc_metro[:red] = red
dc_metro[:turquoise] = turquoise
dc_metro[:orange] = orange

#main

all_stops = getAllStops(dc_metro).join("|")

puts "Where would you like to start?"
point_a = listOptions(all_stops)[1]
puts "And where would you like to end up?"
point_b = listOptions(all_stops)[1]

puts "You want to go from #{point_a} to #{point_b}? (y/n)"
verify = gets.chomp.downcase

total_stops = getFewestStops(dc_metro, point_a, point_b)

puts "Total stops: #{total_stops}"

exit if verify != "y"



