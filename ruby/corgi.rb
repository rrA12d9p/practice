require_relative 'dog.rb'

class Corgi < Dog
  def initialize
    super
    @type = "Corgi"
    @size = "tiny"
    @cuteness = 10
  end

  def bark
    puts "Yap Yap Yap!"
  end
end