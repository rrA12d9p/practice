class Flower
  def initialize(color)
    @kind = ''
    @color = ''
    @how_to_pick = "Break the stem"
  end

  private 

  attr_reader :kind, :color

  def how_to_pick
    puts @how_to_pick
  end
end

class Tulip < Flower
  attr_reader :type

  def initialize (color)
    super
    @type = 'perennial'
    @color = color
  end
end

class Zinnia  < Flower
  def initialize(color)
    # super
    @type = 'annual'
    @color = color
  end
end

class Rose < Flower
  def initialize(color)
    super
    @type = 'perennial'
    @color = color
    @how_to_pick += " Wear gloves. "
  end
end

green_rose = Rose.new('blue')
puts green_rose.color

