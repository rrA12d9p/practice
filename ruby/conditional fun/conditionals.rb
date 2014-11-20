def adjectiveSentiment(adjective)
	negativeListFile = File.open("negative_words.txt")
	positiveListFile = File.open("positive_words.txt")

	negativeListFile.each_line {|keyword|

		keyword = keyword.chomp

		if /#{keyword}/.match(adjective)
			return "negative"
		end
	}

	positiveListFile.each_line {|keyword|

		keyword = keyword.chomp

		if /#{keyword}/.match(adjective)
			return "positive"
		end
	}
end

puts "What's the weather like?"
weather = gets.chomp.downcase

case adjectiveSentiment(weather)
	when "negative"
		puts "That sucks."
	when "positive"
		puts "Awesome!"
	else
		puts "Got it."
end