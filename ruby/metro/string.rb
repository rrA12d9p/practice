class String
  def titlecase
  	words = self.split(" ")
  	new_string = []
  	words.each do |word|
  		new_string << word.capitalize
  	end

    return new_string.join(" ")
  end
end