# Robot (abstract)
class Robot
  def initialize
    @name = 'Marvin'
  end

  def speak
    return get_speaking_quote(get_random_index)
  end

  protected

  def get_speaking_quote(index)
    return "Hello .. I am .. #{@name}"
  end

  private

  def get_random_index
    return Random.new.rand(3)
  end
end


# Protocol Droid (extends Robot)
class ProtocolDroid < Robot
  def initialize
    @name = 'C3PO'
  end

  protected

  def get_speaking_quote(index)
    case index
    when 1
      return "Oh, my! What have you done? I'm BACKWARDS. You flea-bitten furball!"
    when 2
      return "Sir, it's quite possible this asteroid is not entirely stable."
    else
      return "Noisy brute. Why don't we just go to lightspeed?"
    end
  end
end


# Bender (extends Robot)
class Bender < Robot
  def initialize
    @name = 'Bender'
  end

  protected

  def get_speaking_quote(index)
    case index
    when 1
      return "Aw, I just made myself feel bad."
    when 2
      return "Stupid can opener! You killed my father, and now you've come back for me!"
    else
      return "Bite my shiny metal butt."
    end
  end
end

robo = Robot.new
puts robo.speak

c3po = ProtocolDroid.new
puts c3po.speak

bender = Bender.new
puts bender.speak