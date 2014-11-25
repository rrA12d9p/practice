# student class
class Student
	def initialize(name)
		@name = name
	end

	def says_hello
		return "Hi, my name's #{@name}"
	end
end

trey = Student.new("Trey")

puts trey.says_hello