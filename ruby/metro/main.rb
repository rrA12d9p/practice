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
	point_a = list_options(dc_metro.list_all_stops)
	
	puts "Destination:"
	point_b = list_options(dc_metro.list_all_stops)
	
	puts "You want to go from #{point_a[1]} to #{point_b[1]}? (y/n)"
	if gets.chomp.downcase != "y"
		puts "Try again?"
		gets.chomp.downcase == "y" ? next : exit
	end

	puts "Point A is on lines: #{dc_metro.get_lines(point_a[1])}"
	puts "Point B is on lines: #{dc_metro.get_lines(point_b[1])}"
	exit
end
