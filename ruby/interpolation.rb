puts "Oh my god, there's so much blood. What happened here???"
answer = gets.chomp
puts "WTF do you mean, \"#{answer}\"!?!?"
gets.chomp
puts "Yeah, whatever. Officer, arrest this man!"
gets.chomp
puts "You have the right to remain silent. Anything you say can and will be used against you in a court of law. You have the right to an attorney. If you cannot afford an attorney, one will be provided for you. Do you understand the rights I have just read to you? With these rights in mind, do you wish to speak to me?"
answer = gets.chomp
puts "What's your name, scumbag?"
name = gets.chomp.capitalize
if name != ""
	puts "You're going away for a long time, #{name}. Book 'em, Lou."
else
	puts "All right, scumbag. Probably smart keeping your mouth shut. Book 'em, Lou."
end	