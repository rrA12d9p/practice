require_relative 'dog.rb'
require_relative 'doberman.rb'
require_relative 'yellowlab.rb'
require_relative 'corgi.rb'

while 1
  puts "What kind of dog are you looking for? (C)orgi, (Y)ellow Lab, or (D)oberman?"
  dog_type = gets.chomp.downcase

  if dog_type != 'c' && dog_type != 'y' && dog_type != 'd'
    puts 'Sorry, that option is unavailable. Try again? (y/n)'
    try_again = gets.chomp.downcase
    try_again == 'y' ? next : exit
  else
    break
  end
end

dog_hash = {c: Corgi, y: YellowLab, d: Doberman}
dog = dog_hash[dog_type.to_sym].new

puts "Your new dog's name is #{dog.name}"

if dog.gender == "male"
  puts "Be sure to neuter your dog!"
end

if dog.gender == "male"
  "Be sure to neuter your dog!"
else
  puts "Be sure to spay your dog!"
end

puts "Have a great life with #{dog.name}"