require_relative 'dog.rb'

class YellowLab < Dog
  def initialize
    super
    @type = "Yellow Lab"
    @size = "medium"
    @cuteness = 7
  end

  def bark
    puts "Woof woof woof!"
  end
end