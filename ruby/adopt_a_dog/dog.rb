class Dog
	attr_reader :type, :has_tail, :size, :cuteness, :name, :gender

	def initialize
		@type = "Doberman"
		@has_tail = true
		@size = "large"
		@cuteness = 4
		@name = ["Fido", "Sparky", "Rover", "Spot", "Scooby", "Astro", "Lassie"].sample
		@gender = ["male", "female"].sample
	end

	def bark
		puts "Bark bark bark!"
	end
end