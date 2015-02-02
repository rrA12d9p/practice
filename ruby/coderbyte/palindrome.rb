def is_palindrome?(str)
	s_arr = str.downcase.split("")
	mid_i = (s_arr.length - 1) / 2
	(0..mid_i).each do |i|
		mirror_i = -(i + 1)
		return false if s_arr[i] != s_arr[mirror_i]
	end
	return true
end