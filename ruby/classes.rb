class Chair
	def initialize
		@sittable = true
		@legs = 4
		@comfort_level = 0
		@has_a_back = true
	end
end

class ElectricChair < Chair #sublcass of chair
	def initialize(name)
		super
		@can_kill_you = true
		@name = name
	end
end

hallway_chair = Chair.new
p hallway_chair

electric_chair = ElectricChair.new('Old Sparky')
p electric_chair