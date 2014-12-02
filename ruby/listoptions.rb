def list_options(options)
	max_margin = options.length.to_s.length
	begin
		i = 1
		options.each do |option|
			l = i.to_s.length
			m = max_margin + 1 - l
			puts "#{i}.#{" " * m}#{option}"
			i += 1
		end
		
		answer = gets.chomp.to_i

		if answer < 1 || answer > i - 1
			puts "Sorry, please enter a valid number (1-#{i})."
		end
	end while answer < 1 || answer > i - 1
	return [answer, options[answer - 1]]
end