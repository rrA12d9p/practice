def listOptions(options)
	i = 1
	aOptions = options.split("|")
	aOptions.each do |option|
		puts "#{i}. #{option}"
		i += 1
	end

	answer = gets.chomp.to_i

	while answer < 1 || answer > i
		huh(1, i)
		answer = gets.chomp.to_i
	end

	return [answer, aOptions[answer-1]]
end

def huh(min, max)
	puts "Huh? Pick an option between #{min} and #{max - 1}!"
end

puts "Hi! I'm C-3P0, with human-cyborg relations."
puts "Whats your name?"
user_name = gets.chomp.gsub(/\w+/) { |word| word.capitalize }
puts "It is a pleasure to meet you, #{user_name}. Have you ever met a protocol droid before?"
answer = gets.chomp
puts "#{answer}? How interesting, for someone from around these parts."
puts "I'm terribly sorry for prying, but you don't by any chance go by the alias of Obi-Wan Kenobi, do you? (Answer \"I do\" or \"I don't\")"
is_obiwan = gets.chomp.downcase
if is_obiwan == "i do"
	puts "Oh, marvelous! Simply marvelous! Say hello to R2-D2; he's been looking all over for you."
else
	puts "I've really enjoyed speaking with you, #{user_name}, but if you'll please excuse me, I have to help my friend find someone named Obi-Wan Kenobi."	
	bye = listOptions("Bye!|See ya!|Ciao|Farewell|Auf Wiedersehen!|Adios")
	puts "#{bye[1]} to you too."
	puts "Well R2, I suppose we'll just have to keep looking."
	puts "R2-D2: (Agreeable droid noises)"
end