class Workshop
	def initialize
		@students = []
		@coaches = []
		@date
		@venue_name
	end

	def add_participant(member)
		if member.class == 'Student'
			students << member
		elsif member.class = 'Coach'
			coaches << member
		end
	end
end

class Member
	def initialize(full_name)
		@full_name = full_name
		@skills = []
	end

	def add_skill(skill)
		@skills < skill
	end
end

class Student < Member
	def initialize(full_name, bio)
		super
		@bio = bio
	end
end

class Coach < Member
	def initialize
		super
	end
end

