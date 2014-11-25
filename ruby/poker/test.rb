require 'test/unit'
require 'poker'

class TestGame < Test::Unit::TestCase
    def test_game
    	game = Game.new("Poker")
    	expected = game.name
    	assert_equal expected, "Poker"
    end
end