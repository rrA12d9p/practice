require_relative 'dog.rb'

class Doberman < Dog
  def initialize
    super
    @type = "Doberman"
    @size = "large"
    @cuteness = 4
  end

  def bark
    puts "Ruff ruff ruff!"
  end
end