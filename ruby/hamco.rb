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
			system "clear"
			puts "Sorry, that option is unavailable."
		end
	end while answer < 1 || answer > i - 1
	return [answer, aOptions[answer - 1]]
end

system "clear"

selection = listOptions(
  "Convert Temperatures|" +
  "Task Manager|" +
  "NSA Wiretap Request System"
)

case selection[0]
	when 1
		system "clear"
		puts selection[1]
		selection = listOptions(
			"Fahrenheit to Celsius|" +
			"Celsius to Fahrenheit|"
		)
	when 2
		system "clear"
		puts selection[1]
	when 3
		system "clear"
		puts selection[1]
end