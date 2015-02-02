class String
	def is_anagram_for(s)
		return false if self.length != s.length
		
		arr_a = self.split("")
		arr_b = s.split("")

		arr_a.each do |c|
			b_index = arr_b.index(c)
			b_index == nil ? return false : arr_b.delete_at(b_index)
		end
		
		return true
	end
end

puts "test".is_anagram_for("test")