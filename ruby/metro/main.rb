require_relative 'metro.rb'
require_relative 'line.rb'

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
	point_a = list_options(dc_metro.list_all_stops.sort)[1]
	
	puts "Destination:"
	possible_destinations = dc_metro.list_all_stops.select {|stop| stop != point_a}
	point_b = list_options(possible_destinations.sort)[1]
	
	puts "You want to go from #{point_a} to #{point_b}? (y/n)"
	if gets.chomp.downcase != "y"
		puts "Try again?"
		gets.chomp.downcase == "y" ? next : exit
	end
	
	if dc_metro.same_line?(point_a, point_b)
		puts "Good news! #{point_a} and #{point_b} are on the same line."
	else
		puts "Sorry. #{point_a} and #{point_b} aren't on the same line."
	end

	dc_metro.get_lines(point_a).each do |line_a|
		dc_metro.get_lines(point_b).each do |line_b|
			if dc_metro.same_line?(point_a, point_b)
				stops = dc_metro.count_stops(point_a, point_b, line_a)
				puts "Total stops: #{stops}"
			end
		end
	end


	exit
end
