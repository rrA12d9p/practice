def LetterChanges(str)

  str = str.downcase.split("")
  alphabet = ("a".."z").to_a
  shift_num = 1
  
  new_string = ""
  
  str.each do |c|
    c_index = alphabet.index(c)
    if c_index != nil
      c_index = (c_index + shift_num) % alphabet.length
      c = alphabet[c_index]
    end

    c.upcase! if /[aeiou]/ =~ c
    
    new_string << c
  end
  
  # code goes here
  str = new_string
  str.gsub!(/([aeiou])/, '\1'.upcase)
  return str 
end
   
# keep this function call here 
# to see how to enter arguments in Ruby scroll down   
puts LetterChanges("TEST123")