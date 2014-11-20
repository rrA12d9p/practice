puts "What's the current temperature?"
current_temperature = gets.chomp

puts "Is the A/C working? (y/n)"
working = gets.chomp.downcase

puts "What would you like the temperature to be?"
desired_temperature = gets.chomp.downcase

if working == "y"
	if current_temperature == desired_temperature
		puts "Perfect as is."
	elsif current_temperature > desired_temperature
		puts "Turn up the A/C please! It's hot!"
	elsif current_temperature < desired_temperature
		puts "Turn down the A/C please! It's cold!"
	end
else
	if current_temperature == desired_temperature
		puts "You should probably fix the A/C, but you're good for now"
	elsif current_temperature > desired_temperature
		puts "Fix the A/C. It's hot!"
	elsif current_temperature < desired_temperature
		puts "Fix the A/C. It's cold!"
	end
end