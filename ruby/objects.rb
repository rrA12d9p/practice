# student class
class Student
	def initialize(name, age, iq)
		@name = name
		@iq = iq
		@age = age
	end

	def says_hello
		return "Hi, my name's #{@name} and I'm #{@age}"
	end

	def state_iq
		if @iq > 100
			return "My IQ is #{@iq} and I'm above average."
		elsif @iq == 100
			return "My IQ is #{@iq} and I'm average."
		else
			return "My IQ is #{@iq} and I'm below average. :("
		end
	end

	def have_child(name)
		child = Student.new(name, 0, @iq)
	end
end

trey = Student.new("Trey", 24, 50)

puts trey.says_hello

puts trey.state_iq

puts trey.have_child("Baby Trey").says_hello