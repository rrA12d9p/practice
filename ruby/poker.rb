require 'colorize'

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
  	if suit == 'c'
    	"#{@rank}#{@suit}".green
    elsif suit == 'd'
    	"#{@rank}#{@suit}".blue
    elsif suit == 'h'
    	"#{@rank}#{@suit}".red
    else
    	"#{@rank}#{@suit}".yellow
  	end
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

class Hand < Array

	def initialize(cards)
		@hand = cards
		sort_by_value
	end

	def values
		return @hand.collect {|card| card.value}
	end

	def pair_count_hash
		pair_hash = @hand.group_by {|card| card.rank}
		pair_count_hash_array = []
		pair_hash.each do |k, v|
			pair_count_hash_array << {card: k, quantity: v.length, value: Card::RANKS.index(k) + 2}
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
		if is_straight && is_flush && @hand[0].rank == 'A'
			return :royal_flush
		elsif is_straight && is_flush
			return :straight_flush
		elsif pair_count_hash[0][:quantity] == 4
			return :four_of_a_kind
		elsif pair_count_hash[0][:quantity] == 3 && pair_count_hash[1][:quantity] == 2
			return :full_house
		elsif is_flush
			return :flush
		elsif is_straight
			return :straight
		elsif pair_count_hash[0][:quantity] == 3
			return :three_of_a_kind
		elsif pair_count_hash[0][:quantity] == 2 && pair_count_hash[1][:quantity] == 2
			return :two_pair
		elsif pair_count_hash[0][:quantity] == 2
			return :one_pair
		else
			return :high_card
		end
	end

	def to_s
    	@hand.join(", ")
	end

	attr_reader :suit_hash, :num_suits, :num_pairs, :pair_hash

end

class Player

	def initialize(name, hand)
		@name = name
		@hand = hand
		@score_class_order = [:royal_flush, :straight_flush, :four_of_a_kind, :full_house, :flush, :straight, :three_of_a_kind, :two_pair, :one_pair, :high_card]
		@hand_class = hand.score_class
		@hand_class_s = hand.score_class.to_s.gsub('_',' ').capitalize
		@hand_class_rank = @score_class_order.index(@hand_class)
	end

	attr_reader :name, :hand, :hand_class, :hand_class_rank, :hand_class_s
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

	def compare_hands(players)
		winners = []
		players.each do |player|
			if winners.length == 0
				winners << player
			elsif player.hand_class_rank < winners[-1].hand_class_rank
				# better hand class rank than current winner(s)
				winners = [player]
			elsif player.hand_class_rank == winners[-1].hand_class_rank
				# same hand class rank (e.g. full house) as current winner(s)
				case player.hand_class
					when :royal_flush
						winners << player
					when :straight_flush
						player_a_high_card = winners[-1].hand[0].value
						player_b_high_card = player.hand[0].value
						if player_b_high_card > player_a_high_card
							winners = [player]
						elsif player_b_high_card == player_a_high_card
							winners << player
						end
					when :four_of_a_kind
						player_a_pair_card = winners[-1].hand.pair_count_hash[0][:value]
						player_b_pair_card = player.hand.pair_count_hash[0][:value]

						if player_b_pair_card > player_a_pair_card
							winners = [player]
						else
							player_a_kicker = winners[-1].hand.pair_count_hash_array[-1][:value]
							player_b_kicker= player.hand.pair_count_hash_array[-1][:value]
							if player_b_high_card > player_a_high_card
								winners = [player]
							elsif player_b_high_card == player_a_high_card
								winners << player
							end
						end
					when :full_house
						player_a_trip_card = winners[-1].hand.pair_count_hash[0][:value]
						player_b_trip_card = player.hand.pair_count_hash[0][:value]

						if player_b_trip_card > player_a_trip_card
							winners = [player]
							# only condition necessary, as two players can't have the same trip card
							# (i.e. AAAKK vs AAAKK is impossible)
						end
					when :flush
						player_a_hand_values = winners[-1].hand.values
						player_b_hand_values = player.hand.values

						# check if the hands are identical except for suit
						if player_a_hand_values == player_b_hand_values
							winners << player
							next
						end

						player.hand.each_with_index do |card, i|
							if card.value > winners[-1].hand[i].value
								winners = [player]
								break
							else
							end
						end


					when :straight
						player_a_high_card = winners[-1].hand[0].value
						player_b_high_card = player.hand[0].value
						if player_b_high_card > player_a_high_card
							winners = [player]
						elsif player_b_high_card == player_a_high_card
							winners << player
						end
					when :three_of_a_kind
						player_a_hand_values = winners[-1].hand.values
						player_b_hand_values = player.hand.values

						# check if the hands are identical except for suit
						if player_a_hand_values == player_b_hand_values
							winners << player
							next
						end

						player_a_pair_card = winners[-1].hand.pair_count_hash[0][:value]
						player_b_pair_card = player.hand.pair_count_hash[0][:value]

						if player_b_pair_card > player_a_pair_card
							winners = [player]
						elsif player_b_pair_card == player_a_pair_card
							player.hand.each_with_index do |card, i|
								if card.value > winners[-1].hand[i].value
									winners = [player]
									break
								else
								end
							end
						else
						end
					when :two_pair
						player_a_hand_values = winners[-1].hand.values
						player_b_hand_values = player.hand.values

						# check if the hands are identical except for suit
						if player_a_hand_values == player_b_hand_values
							winners << player
							next
						end

						player_a_pair_card_one = winners[-1].hand.pair_count_hash[0][:value]
						player_b_pair_card_one = player.hand.pair_count_hash[0][:value]

						player_a_pair_card_two = winners[-1].hand.pair_count_hash_array[1][:value]
						player_b_pair_card_two = player.hand.pair_count_hash_array[1][:value]

						if player_b_pair_card_one > player_a_pair_card_one
							winners = [player]
						elsif player_b_pair_card_one == player_a_pair_card_one
							if player_b_pair_card_two > player_a_pair_card_two
								winner = [player]
							elsif player_b_pair_card_two == player_a_pair_card_two
								player.hand.each_with_index do |card, i|
									if card.value > winners[-1].hand[i].value
										winners = [player]
										break
									else
									end
								end

							else
							end
						else
						end
					when :one_pair
						player_a_hand_values = winners[-1].hand.values
						player_b_hand_values = player.hand.values

						# check if the hands are identical except for suit
						if player_a_hand_values == player_b_hand_values
							winners << player
							next
						end

						player_a_pair_card = winners[-1].hand.pair_count_hash[0][:value]
						player_b_pair_card = player.hand.pair_count_hash[0][:value]

						if player_b_pair_card > player_a_pair_card
							winners = [player]
						elsif player_b_pair_card == player_a_pair_card
							player.hand.each_with_index do |card, i|
								if card.value > winners[-1].hand[i].value
									winners = [player]
									break
								else
								end
							end

						else
						end
					when :high_card
						player_a_hand_values = winners[-1].hand.values
						player_b_hand_values = player.hand.values

						# check if the hands are identical except for suit
						if player_a_hand_values == player_b_hand_values
							winners << player
							next
						end

						player.hand.each_with_index do |card, i|
							if card.value > winners[-1].hand[i].value
								winners = [player]
								break
							else
							end
						end
				end
				
			else
			end
		end	

		return winners
	end

	attr_accessor :name, :players, :winners, :winning_score
end

poker = Game.new("Poker")
deck = Deck.new

# hand = Hand.new([Card.new('A', 's'), Card.new('2', 's'), Card.new('9', 's'), Card.new('4', 's'), Card.new('5', 's')])
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
	puts "#{player.name}: #{player.hand.to_s} (#{player.hand_class_s})"
end

winners = poker.compare_hands(poker.players)

winner_names = winners.collect {|player| player.name}

puts "Winner#{winners.length > 1 ? "s" : ""}: #{winner_names.join(", ")}"