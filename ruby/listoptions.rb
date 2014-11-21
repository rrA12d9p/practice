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

choice = listOptions("option 1|option 2|option 3")
puts "You picked #{choice[1]}"