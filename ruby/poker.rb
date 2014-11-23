# require "pry"

class Card
  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(c d h s)
 
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = RANKS.index(rank) + 2
  end

  attr_reader :rank, :suit, :value
 
  def to_s
    "#{@rank}#{@suit}"
  end
end

class Deck
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
   @cards.shuffle!
  end

  attr_reader :cards
 
  # returns an array of cards and removes those cards from the deck
  def deal(n=1)
    @cards.pop(n)
  end
 
  def empty?
    @cards.empty?
  end
 
  def cards_remaining
    @cards.length
  end
end

class Player
	def initialize(name, hand)
		@name = name
		@hand = hand
	end

	attr_reader :name, :hand
end

class Hand

	def initialize(cards)
		@hand = cards
		sort_by_value
	end

	def pair_count_hash
		pair_hash = @hand.group_by {|card| card.rank}
		pair_count_hash_array = []
		pair_hash.each do |k, v|
			pair_count_hash_array << {card: k, quantity: v.length}
		end
		pair_count_hash_array.sort { |a,b| b[:quantity] <=> a[:quantity] }
	end

	def sort_by_value
		@hand.sort! {|card_a, card_b| card_b.value <=> card_a.value}
	end

	def add_card(card)
		@hand += card
		sort_by_value
	end

	def remove_card(card)
		@hand -= card
	end

	def count_suits
		suit_hash = @hand.group_by {|card| card.suit}
		suit_hash.length
	end

	def is_flush
		count_suits == 1
	end

	def high_card
		@hand[0].rank
	end

	def is_straight
		sort_by_value
		high_card_value = @hand[0].value
		# puts high_card_value
		low_card_value = @hand[-1].value
		# puts low_card_value
		if high_card_value - low_card_value == 4 && pair_count_hash[0][:quantity] == 1
			return true #regular straight
		elsif @hand[0].value == 14 && @hand[1].value == 5 && @hand[1].value - @hand[-1].value == 3 && pair_count_hash[0][:quantity] == 1
			return true #ace is low straight
		else
			return false
		end
	end

	def score_class
		score_class = {
			royal_flush: false,
			straight_flush: false,
			four_of_a_kind: false,
			full_house: false,
			flush: false,
			straight: false,
			three_of_a_kind: false,
			two_pair: false,
			one_pair: false,
			high_card: false
		}

		if is_straight && is_flush && @hand[0].rank == 'A'
			score_class[:royal_flush] = true
		elsif is_straight && is_flush
			score_class[:straight_flush] == true
		elsif pair_count_hash[0][:quantity] == 4
			score_class[:four_of_a_kind] = true
		elsif pair_count_hash[0][:quantity] == 3 && pair_count_hash[1][:quantity] == 2
			score_class[:full_house] = true
		elsif is_flush
			score_class[:flush] = true
		elsif is_straight
			score_class[:straight] = true
		elsif pair_count_hash[0][:quantity] == 3
			score_class[:three_of_a_kind] = true
		elsif pair_count_hash[0][:quantity] == 2 && pair_count_hash[1][:quantity] == 2
			score_class[:two_pair] = true
		elsif pair_count_hash[0][:quantity] == 2
			score_class[:one_pair] = true
		else
			score_class[:high_card] = true
		end
			
		score_class.each do |k, v|
			if v == true
				return k
			end
		end
	end

	def to_s
    	@hand.join(", ")
	end

	attr_reader :suit_hash, :num_suits, :num_pairs, :pair_hash

end

class Game

	def player_count
		@players.length
	end

	def initialize(name)
		@name = name
		@players = []
		@winners = []
		@winning_score = 0
	end

	def add_player(player)
		@players << player
	end

	def winner
		players.each do |player|
			#group players by hand score
		end
	end

	attr_accessor :name, :players, :winners, :winning_score
end

poker = Game.new("Poker")
deck = Deck.new

# hand = Hand.new([Card.new('A', 's'), Card.new('2', 's'), Card.new('2', 'h'), Card.new('4', 's'), Card.new('5', 'h')])
# new_player = Player.new("Trey", hand)
# poker.add_player(new_player)

while true
	if poker.player_count == 0
		puts "No players yet. Enter a player name, or type 'play':"
	else
		puts "#{poker.player_count} players so far. Enter a player name, or type 'play':"
	end
	
	name = gets.chomp.capitalize

	if name == "Play"
		break
	else
		hand = Hand.new(deck.deal(5))
		new_player = Player.new(name, hand)
		poker.add_player(new_player)
	end
end

poker.players.each do |player|
	puts "================="
	puts "#{player.name}: #{player.hand.to_s}"
	puts "Score: #{player.hand.score_class}"
end

# binding.pry